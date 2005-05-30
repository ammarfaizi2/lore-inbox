Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVE3IA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVE3IA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 04:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVE3IA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 04:00:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22970 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261551AbVE3IAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 04:00:53 -0400
Date: Mon, 30 May 2005 09:59:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/7] UML - set_tsk_need_resched
Message-ID: <20050530075931.GA13119@elf.ucw.cz>
References: <200505262230.j4QMUGVh014671@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505262230.j4QMUGVh014671@ccure.user-mode-linux.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the UML resched patch.  Please stick it in with the other arch resched
> fixes.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.11/arch/um/kernel/process_kern.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/process_kern.c	2005-05-26 14:01:28.000000000 -0400
> +++ linux-2.6.11/arch/um/kernel/process_kern.c	2005-05-26 14:31:46.000000000 -0400
> @@ -188,6 +188,8 @@ void default_idle(void)
>  	current->mm = &init_mm;
>  	current->active_mm = &init_mm;
>  
> +        set_tsk_need_resched(current);
> +
>  	while(1){
>  		/* endless idle loop with no priority at all */
>  		SET_PRI(current);

Seems to me you are have some tabs-vs-spaces problems. Plus it would
be nice to write

	while (1) {
instead of
	while(1){
								Pavel
