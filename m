Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbTAXCZW>; Thu, 23 Jan 2003 21:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbTAXCZW>; Thu, 23 Jan 2003 21:25:22 -0500
Received: from ns2.mountaincable.net ([24.215.0.12]:44725 "EHLO
	ns2.mountaincable.net") by vger.kernel.org with ESMTP
	id <S267509AbTAXCZI>; Thu, 23 Jan 2003 21:25:08 -0500
Subject: Re: ieee1394: Node 01:1023 has non-standard ROM format (0 quads),
	cannot parse
From: desrt <desrt@desrt.ca>
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030124014815.GB4524@hopper.phunnypharm.org>
References: <1043372135.1442.7.camel@nothing.desrt.ca>
	 <20030124014815.GB4524@hopper.phunnypharm.org>
Content-Type: text/plain
Organization: 
Message-Id: <1043375612.1889.7.camel@nothing.desrt.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 23 Jan 2003 21:33:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If one cdrom works in the enclosure and another doesn't, then I suspect
> something is weird with the enclosure's detection of the device you
> placed in it. Are you sure that the master/slave jumpers are set
> correctly for the enclosure? Anything else it needs?
They were both set to master.  The enclosure itself doesn't have any
jumpers really, but I changed the jumpers around on the dvd drive (after
receiving your email) and tested various combinations (ie: master,
slave, cable select, and the DMA jumper on/off.)  None of these worked.

Some other stuff I played with:  I noticed that the drive locks shut
with the 'busy' light on.  but:
- drive not connected to enclosure: eject works, busy light off
- drive connected to enclosure, but enclosure not plugged into firewire
bus (ie: controller card): eject doesn't work, busy light on
- connected, on the bus, ohci1394 module not loaded: eject works, busy
light off
- connected, on bus, ohci1394 loaded: eject doesn't work, busy light on

Also, transitioning from one of the 'working' states to one of the
non-working states doesn't work (ie: the unloading the ohci1394
driver.)  The drive gets "stuck" in it's busy-not-working state until
you powercycle the enclosure.

Is it possible that my enclosure just doesn't support DVD drives?

Thanks again

