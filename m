Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWHHUfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWHHUfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWHHUfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:35:07 -0400
Received: from www.osadl.org ([213.239.205.134]:38795 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030299AbWHHUfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:35:05 -0400
Subject: Re: [PATCH] fix hrtimer percpu usage typo
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jan Blunck <jblunck@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060807130729.GT4995@hasse.suse.de>
References: <20060807130729.GT4995@hasse.suse.de>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 22:37:10 +0200
Message-Id: <1155069430.5192.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 15:07 +0200, Jan Blunck wrote:

Can you please inline patches ?

Acked-by: Thomas Gleixner <tglx@linutronix.de>


> From: Jan Blunck <jblunck@suse.de>
> Subject: fix hrtimer percpu usage
> 
> The percpu variable is used incorrectly in switch_hrtimer_base().
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>
> ---
>  kernel/hrtimer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/kernel/hrtimer.c
> ===================================================================
> --- linux-2.6.orig/kernel/hrtimer.c
> +++ linux-2.6/kernel/hrtimer.c
> @@ -187,7 +187,7 @@ switch_hrtimer_base(struct hrtimer *time
>  {
>         struct hrtimer_base *new_base;
>  
> -       new_base = &__get_cpu_var(hrtimer_bases[base->index]);
> +       new_base = &__get_cpu_var(hrtimer_bases)[base->index];
>  
>         if (base != new_base) {
>                 /*
> 

