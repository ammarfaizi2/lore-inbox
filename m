Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289889AbSAWPtE>; Wed, 23 Jan 2002 10:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289891AbSAWPsz>; Wed, 23 Jan 2002 10:48:55 -0500
Received: from gw.wmich.edu ([141.218.1.100]:32496 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S289889AbSAWPsj>;
	Wed, 23 Jan 2002 10:48:39 -0500
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Timothy Covell <timothy.covell@ashavan.org>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>, Dave Jones <davej@suse.de>,
        Andreas Jaeger <aj@suse.de>, Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201231411240.31513-100000@hades.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201231411240.31513-100000@hades.uni-trier.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 23 Jan 2002 10:47:19 -0500
Message-Id: <1011800844.21246.10.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-23 at 08:19, Daniel Nofftz wrote:
> On Wed, 23 Jan 2002, Vojtech Pavlik wrote:
> > Won't ACPI idle do that well enough?
> 
> yes ... and no!
> first: my patch is useless, if you don't activate acpi idle calls ...
> second: the idle calls will not save power on an athlon/duron/athlon xp ,
> unless a specific bit in the chipset is set, which will cause the chipset
> to disconnect the frontside bus of the cpu ... and this is what the patch
> does: it sets only the bit in the northbridge of the kt133/kx133 and
> kt266/266a chipset ... -> now the acpi idle calls will bring power saving
> and lesser temperature
> the patch inserts a pci_quirk function which sets the bit in the
> northbridge ... (at the boot-prompt you have to pass the comment
> amd_disconnect=yes to use this function ...)
> 
> daniel

What's the official word on the resulting stress on the hardware from
disconnecting and connecting rapidly like that?   Has any test ever been
carried out to see if it causes damage after say, a couple months of
use?  ...in other operating systems that had this already of course.  
always something not so safe sounding about turning the cpu on and off
rapidly added to the greater temperature extremes.   Also, can you
relink your patch?

