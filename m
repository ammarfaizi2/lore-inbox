Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUGJPIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUGJPIR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUGJPIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:08:17 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:39411 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S266263AbUGJPIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:08:16 -0400
Date: Sat, 10 Jul 2004 11:42:12 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Tim Bird <tim.bird@am.sony.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-ID: <20040710114212.B29889@mail.kroptech.com>
References: <40EEF10F.1030404@am.sony.com> <20040709193528.A23508@mail.kroptech.com> <40EF3637.4090105@am.sony.com> <20040709220142.B29198@mail.kroptech.com> <40EF4E16.8000709@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40EF4E16.8000709@mvista.com>; from tpoynor@mvista.com on Fri, Jul 09, 2004 at 07:01:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 07:01:58PM -0700, Todd Poynor wrote:
> Adam Kropelin wrote:
> 
> > +	if (preset_lpj) {
> > +		loops_per_jiffy = preset_lpj;
> > +		printk("Calibrating delay loop (skipped)... ");
> 
> Suggest a "\n" at the end of that.

Indeed. I propogated that bug from the original patch. I'll fix it.

> Maybe add the precomputed value to 
> help bring incorrect presets to someone's attention, something like:
> 
> +		printk("BogoMIPS preset to %lu.%02lu\n",
> +			loops_per_jiffy/(500000/HZ),
> +			(loops_per_jiffy/(5000/HZ)) % 100);

Will do.

>  > + If unsure, set this to 0. An incorrect value will cause delays in
>  > + the kernel to be incorrect.  Although unlikely, in the extreme case
>  > + this might damage your hardware.
> 
> I suppose it may result in unpredictable I/O errors, in case we want to 
> warn against that.

Easy enough to throw it in.

Another patch is forthcoming.

--Adam

