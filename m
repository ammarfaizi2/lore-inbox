Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVGFFXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVGFFXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVGFFWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:22:11 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:59836 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261617AbVGFDnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:43:10 -0400
Subject: Re: [PATCH] [11/48] Suspend2 2.1.9.8 for 2.6.12:
	401-e820-table-support.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shaohua.li@intel.com
In-Reply-To: <Pine.LNX.4.61.0507052131140.2149@montezuma.fsmlabs.com>
References: <11206164403490@foobar.com>
	 <Pine.LNX.4.61.0507052131140.2149@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120621474.4860.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 13:44:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 13:35, Zwane Mwaikambo wrote:
> On Wed, 6 Jul 2005, Nigel Cunningham wrote:
> 
> > diff -ruNp 402-mtrr-remove-sysdev.patch-old/arch/i386/kernel/cpu/mtrr/main.c 402-mtrr-remove-sysdev.patch-new/arch/i386/kernel/cpu/mtrr/main.c
> > --- 402-mtrr-remove-sysdev.patch-old/arch/i386/kernel/cpu/mtrr/main.c	2005-06-20 11:46:42.000000000 +1000
> > +++ 402-mtrr-remove-sysdev.patch-new/arch/i386/kernel/cpu/mtrr/main.c	2005-07-04 23:14:19.000000000 +1000
> > @@ -166,7 +166,6 @@ static void ipi_handler(void *info)
> >  	atomic_dec(&data->count);
> >  	local_irq_restore(flags);
> >  }
> > -
> >  #endif
> >  
> >  /**
> > @@ -560,7 +559,7 @@ struct mtrr_value {
> >  
> >  static struct mtrr_value * mtrr_state;
> >  
> > -static int mtrr_save(struct sys_device * sysdev, u32 state)
> > +int mtrr_save(void)
> >  {
> >  	int i;
> >  	int size = num_var_ranges * sizeof(struct mtrr_value);
> > @@ -580,28 +579,27 @@ static int mtrr_save(struct sys_device *
> >  	return 0;
> >  }
> 
> Isn't this covered by Shaohua Li's patch?

I believe so, but Shaohua Li's patch isn't merged in 2.6.12 (is it yet
at all). This is the solution I've been using for... can't remember how
long.

Thanks for the feedback.

Regards,

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

