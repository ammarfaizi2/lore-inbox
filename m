Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbREQWmY>; Thu, 17 May 2001 18:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbREQWmP>; Thu, 17 May 2001 18:42:15 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:53008 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262203AbREQWl6>; Thu, 17 May 2001 18:41:58 -0400
Date: 17 May 2001 23:23:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <811opRpHw-B@khms.westfalen.de>
In-Reply-To: <p05100316b7272cdfd50c@[207.213.214.37]>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com> <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com> <p05100316b7272cdfd50c@[207.213.214.37]>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlundell@pobox.com (Jonathan Lundell)  wrote on 15.05.01 in <p05100316b7272cdfd50c@[207.213.214.37]>:

> What about:
>
> 1 (network domain). I have two network interfaces that I connect to
> two different network segments, eth0 & eth1; they're ifconfig'd to
> the appropriate IP and MAC addresses. I really do need to know
> physically which (physical) hole to plug my eth0 cable into.

Sorry, the software doesn't know that. Never has, for that matter.

> (Extension: same situation, but it's a firewall and I've got 12 ports
> to connect.) (Extension #2: if I add a NIC to the system and reboot,
> I'd really prefer that the NICs already in use didn't get renumbered.)

Make your config script look at the hardware MAC addresses. Those don't  
change.

> 2 (disk domain). I have multiple spindles on multiple SCSI adapters.
> I want to allocate them to more than one RAID0/1/5 set, with the
> usual considerations of putting mirrors on different adapters,
> spreading my RAID5 drives optimally, ditto stripes. I need (eg) SCSI
> paths to config all this, and I further need real physical locations
> to identify failed drives that need to be hot-replaced. The mirror
> members will move around as drives are replaced and hot spares come
> into play.

Use partition UUIDs, or SCSI serial numbers, or whatever. This works  
today.

> Seems like more that merely informational.

The *location*? Nope. Some unique id for the device, if available at all:  
sure.

> (A side observation: PCI or SCSI bus/device/lun/etc paths are not
> physical locations; you also need external hardware-specific
> knowledge to be able to talk about real physical locations in a way
> that does the system operator any good.)

And those you typically do not have.

MfG Kai
