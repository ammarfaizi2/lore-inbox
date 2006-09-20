Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWITVqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWITVqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWITVqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:46:18 -0400
Received: from 1wt.eu ([62.212.114.60]:7955 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S932159AbWITVqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:46:18 -0400
Date: Wed, 20 Sep 2006 23:28:15 +0200
From: Willy Tarreau <w@1wt.eu>
To: Toyo Abe <toyoa@mvista.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.4] x86_64: Fix missing delay when the TSC counter just overflowed
Message-ID: <20060920212815.GA9397@1wt.eu>
References: <200609202143.k8KLhsxg007647@dhcp119.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609202143.k8KLhsxg007647@dhcp119.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 02:43:54PM -0700, Toyo Abe wrote:
> I'd seen a problem that *delay functions return in too short delay.
> It happens when the lower 32bit of TSC counter is overflowed.
> This patch fixes the problem. This is back-port of Andi Kleen's
> 2.6 fix.
> 
> http://www.kernel.org/git/?p=linux/kernel/git/tglx/history.git;a=commit;h=6c51e28ffbbebf49437ec63ac4f9e385d60827e5
> 
> Signed-off-by: Toyo Abe <toyoa@mvista.com>
> 
> ---
> 
>  arch/x86_64/lib/delay.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86_64/lib/delay.c b/arch/x86_64/lib/delay.c
> index cc845d2..91345ee 100644
> --- a/arch/x86_64/lib/delay.c
> +++ b/arch/x86_64/lib/delay.c
> @@ -19,7 +19,7 @@ #endif
>  
>  void __delay(unsigned long loops)
>  {
> -	unsigned long bclock, now;
> +	unsigned bclock, now;
>  	
>  	rdtscl(bclock);
>  	do

Queued.

Thanks Toyo,
Willy

