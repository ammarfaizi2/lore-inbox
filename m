Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUGJOs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUGJOs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 10:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266277AbUGJOs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 10:48:56 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:28915 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S266274AbUGJOsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 10:48:55 -0400
Date: Sat, 10 Jul 2004 11:22:51 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tim Bird <tim.bird@am.sony.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: [Celinux-dev] Re: [PATCH] preset loops_per_jiffy for faster booting
Message-ID: <20040710112251.A29889@mail.kroptech.com>
References: <40EEF10F.1030404@am.sony.com> <20040709193528.A23508@mail.kroptech.com> <40EF3637.4090105@am.sony.com> <20040709220142.B29198@mail.kroptech.com> <Pine.GSO.4.58.0407101639580.10242@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.58.0407101639580.10242@waterleaf.sonytel.be>; from geert@linux-m68k.org on Sat, Jul 10, 2004 at 04:41:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 04:41:04PM +0200, Geert Uytterhoeven wrote:
> On Fri, 9 Jul 2004, Adam Kropelin wrote:
> > On Fri, Jul 09, 2004 at 05:20:07PM -0700, Tim Bird wrote:
> > > Adam Kropelin wrote:
> > +		printk("Set 'Preset loops_per_jiffy'=%lu for preset lpj.\n",
> > +			loops_per_jiffy);
> 
> > +config PRESET_LPJ
> > +	int "Preset loops_per_jiffy" if FASTBOOT
> > +	default 0
> > +	help
> > +	  This is the number of loops used by delay() to achieve a single
> > +	  jiffy of delay inside the kernel.  It is normally calculated at
> > +	  boot time, but that calculation can take up to 250 ms per CPU.
> > +	  Specifying a constant value here will eliminate that delay.
> > +
> > +	  loops_per_jiffy is roughly BogoMips * 5000. To determine the correct
> > +	  value for your kernel, first turn off the fast booting option,
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +	  compile and boot the kernel on your target hardware, then see what
> > +	  value is printed during the kernel boot.  Use that value here.
> 
> This is no longer true, it will always print the value if lpj=0.

True enough. I'll fix that along with the things Todd noticed.

--Adam

