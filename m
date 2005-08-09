Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVHIG1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVHIG1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 02:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVHIG1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 02:27:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62868 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932364AbVHIG1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 02:27:54 -0400
Date: Mon, 8 Aug 2005 23:25:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset release ABBA deadlock fix
Message-Id: <20050808232558.7173fdd7.akpm@osdl.org>
In-Reply-To: <20050808223722.22843.86768.sendpatchset@jackhammer.engr.sgi.com>
References: <20050808223722.22843.86768.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Fix possible cpuset_sem ABBA deadlock if 'notify_on_release' set.
> 

So..  Is this 2.6.13-safe?

> +	(void) call_usermodehelper(argv[0], argv, envp, 0);

ick.  Why the cast?
