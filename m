Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTAETtC>; Sun, 5 Jan 2003 14:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTAETtB>; Sun, 5 Jan 2003 14:49:01 -0500
Received: from tag.witbe.net ([81.88.96.48]:33544 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S265135AbTAETtA>;
	Sun, 5 Jan 2003 14:49:00 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Justin T. Gibbs'" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
Date: Sun, 5 Jan 2003 20:57:32 +0100
Organization: Witbe.net
Message-ID: <013901c2b4f4$af8c42a0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <452090000.1041785566@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> There may be options in your BIOS to disable this "feature".  
> Look for things like "PCI byte-merging" and/or "PCI read 
> prefetch".  I haven't had access to one of the new SIS based 
> P4 systems yet, so I don't know how they are setup or exactly 
> how they are violating the PCI spec.  The test will fail 
> either if byte-merging or read prefetch occurs and perhaps if 
> there is an MTTR covering the memory mapped region of the 
> chip that is set to write combining mode (I don't think that 
> the mb() we issue after every memory write helps in this last case).

I've been looking at the PCI option in the BIOS...

1st part is mapping IRQ to PCI slots...
Then, you have :
PCI/VGA Palette Snoop         Disabled
PCI Latency Timer             32
Primary VGA BIOS              PCI VGA Card
USB Function                  Enabled
USB2.0 Function               Enabled
Onboard LAN Boot ROM          Disabled

Maybe related, the memory config :
SDRAM Configuration           By SPD
Chipset clock mode            Synchronous
SDRam Command Lead-off time   Auto
Graphics Aperture Size        256 MB
AGP Capability                4x Mode
AGP Fast Write Capability     Enabled
Video Memory Cache Mode       UC
Memory hole at 15M-16M        Disabled
PCI 2.1 Support               Enabled
Onboard PCI IDE Enable        Both
IDE Bus Master Support        Enabled

Could it be PCI 2.1 Support ? Don't think because I've restarted
with it disabled, and I still have the same problem...

Regards,
Paul

