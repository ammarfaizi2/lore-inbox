Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129750AbRBASVK>; Thu, 1 Feb 2001 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130601AbRBASVB>; Thu, 1 Feb 2001 13:21:01 -0500
Received: from winds.org ([207.48.83.9]:56077 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129750AbRBASUn>;
	Thu, 1 Feb 2001 13:20:43 -0500
Date: Thu, 1 Feb 2001 13:20:00 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: safemode <safemode@voicenet.com>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <20010201190653.H2341@suse.cz>
Message-ID: <Pine.LNX.4.21.0102011316210.27273-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Vojtech Pavlik wrote:

> On Thu, Feb 01, 2001 at 11:46:08AM -0500, Byron Stanoszek wrote:
> 
> > Yeah, by bios does the same thing too on the Abit KT7(a).
> 
> Ok, I'll remember this. This is most likely the cause of the problems
> many people had with the KT7 in the past.

What cause are you referring to? As far as I know, there are two options to
increasing the FSB clock.. one increases both FSB+PCICLK, the other just
increases FSB. If you increase the FSB only, it should keep PCICLK at a solid
33. (But I could be wrong, I've never tested that. I can tomorrow though.)

> The U33 chips do UDMA timing in PCICLK (T = 30ns @ 33MHz) increments, U66 in
> PCICLK*2 (T = 15ns @ 33 MHz) increments, and for U100 it's assumed that
> there is an external 100MHz clock fed to the chip, so that the UDMA timing is
> in T = 10ns increments independent of the PCICLK. I'm not 100% sure about
> the last, it might be just PCICLK*3 (T = 10ns @ 33 MHz). An experiment needs
> to be carried out to verify this.

I don't have a KT7A personally, I only have a KT7. Can anyone else with a KT7A
verify this? By verify, I take it you mean to use idebus=33 and overclock
PCICLK? :) At least that would determine if UDMA100 is based on PCI or an
external 100MHz source.

Regards,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
