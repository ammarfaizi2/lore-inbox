Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWBRIrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWBRIrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 03:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWBRIrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 03:47:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750993AbWBRIrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 03:47:21 -0500
Date: Sat, 18 Feb 2006 00:45:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH 1/2] rcu batch tuning
Message-Id: <20060218004551.19358b6d.akpm@osdl.org>
In-Reply-To: <20060217154337.GM29846@in.ibm.com>
References: <20060217154147.GL29846@in.ibm.com>
	<20060217154337.GM29846@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> -module_param(maxbatch, int, 0);
>  +module_param(blimit, int, 0);
>  +module_param(qhimark, int, 0);
>  +module_param(qlowmark, int, 0);
>  +#ifdef CONFIG_SMP
>  +module_param(rsinterval, int, 0);
>  +#endif

It's a bit unusual to add boot-time tunables via module_param, but there's
no law against it.

But you do get arrested for not adding them to
Documentation/kernel-parameters.txt.  That's if you think they're permanent
(I hope they aren't).  If they are, they'll probably need a more extensive
description than kernel-parameters.txt entries normally provide.
