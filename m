Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287376AbSALTku>; Sat, 12 Jan 2002 14:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287342AbSALTkk>; Sat, 12 Jan 2002 14:40:40 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:45830 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S285166AbSALTkc>;
	Sat, 12 Jan 2002 14:40:32 -0500
Date: Sat, 12 Jan 2002 12:36:04 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@fenrus.demon.nl,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112123604.C6034@hq.fsmlabs.com>
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu> <1010863588.2007.34.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1010863588.2007.34.camel@phantasy>; from rml@tech9.net on Sat, Jan 12, 2002 at 02:26:27PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 02:26:27PM -0500, Robert Love wrote:
> On Sat, 2002-01-12 at 13:54, Alan Cox wrote:
> > Another example is in the network drivers. The 8390 core for one example
> > carefully disables an IRQ on the card so that it can avoid spinlocking on 
> > uniprocessor boxes.
> > 
> > So with pre-empt this happens
> > 
> > 	driver magic
> > 	disable_irq(dev->irq)
> > PRE-EMPT:
> > 	[large periods of time running other code]
> > PRE-EMPT:
> > 	We get back and we've missed 300 packets, the serial port sharing
> > 	the IRQ has dropped our internet connection completely.
> 
> We don't preempt while IRQ are disabled.

You read the mask map? and somehow figure out which masked irqs correspond to 
active devices?

> 
> 	Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

