Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVKOEUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVKOEUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVKOEUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:20:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932367AbVKOEUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:20:37 -0500
Date: Mon, 14 Nov 2005 20:20:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
Message-Id: <20051114202017.6f8c0327.akpm@osdl.org>
In-Reply-To: <43796596.2010908@watson.ibm.com>
References: <43796596.2010908@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> +	*ts = sched_clock();

I'm not sure that it's kosher to use sched_clock() for fine-grained
timestamping like this.  Ingo had issues with it last time this happened?  

<too lazy to read all the code> Do you normalise these numbers in some
manner before presenting them to userspace?  If so, by what means?

