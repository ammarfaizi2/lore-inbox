Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbSKQXby>; Sun, 17 Nov 2002 18:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbSKQXby>; Sun, 17 Nov 2002 18:31:54 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:49870 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S267018AbSKQXbu> convert rfc822-to-8bit;
	Sun, 17 Nov 2002 18:31:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Justin A <ja6447@albany.edu>
To: Adam Belay <ambx1@neo.rr.com>
Subject: Re: pnpbios oops on boot w/ 2.5.47
Date: Sun, 17 Nov 2002 18:41:09 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
References: <200211161700.29653.ja6447@albany.edu> <200211170100.53986.ja6447@albany.edu> <20021117180538.GC1273@neo.rr.com>
In-Reply-To: <20021117180538.GC1273@neo.rr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211171841.09794.ja6447@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 November 2002 01:05 pm, Adam Belay wrote:
> >
> > pnp: the driver 'serial' has been registered
> > pnp: pnp: match found with the PnP device '00:13' and the driver 'serial'
> > pnp: the device '00:13' has been activated
> > PnPBIOS: set_dev_node: Unexpected status 0x85
>
> Hmm, this isn't right.  0x85 means unable to set resources.  If you have it
> could you please send me a copy of the output of lspnp for node 13.  I'm
> not sure what this device is, do you have a second serial port?
>
> Thanks,
> Adam

lspnp output at the end.

It has 2 infrared ports(well its the same port in 2 places....) , one rs232 
port on the back, and a modem port.

This is an IBM thinkpad, so imagine BIOS from hell, its all gooey and 
useless...  I think you are supposed to be able to switch the serial port 
from infrared to the rs232 port, but I don't know how.  I use the infrared 
anyway so thats ok :)

It might be flipping out over the modem, its one of those mwave DSP things.  
Neither the modem or the sound work in linux right now... I would need to 
install http://www-124.ibm.com/acpmodem/ to get just the modem working..and I 
really don't even care :)

If anything I would like the sound to work.  I think once its initialized it 
ends up being sb compatible, but I think even then its only 8bit sound, which 
isn't even worth it.

even after 
"PnPBIOS: set_dev_node: Unexpected status 0x85"

The IR port still works, so it doesn't seem to break anything...

13 PNP0501 communications device: RS-232
    flags: none [static]
    allocated resources:
        irq disabled [high edge]
        io disabled
    possible resources:
        [start dep fn]
        irq 4 [high edge]
        io 0x03f8-0x03ff
        [start dep fn]
        irq 3 [high edge]
        io 0x02f8-0x02ff
        [start dep fn]
        irq 4 [high edge]
        io 0x03e8-0x03ef
        [start dep fn]
        irq 3 [high edge]
        io 0x02e8-0x02ef
        [end dep fn]

00 PNP0000 system peripheral: programmable interrupt controller
01 PNP0200 system peripheral: DMA controller
02 PNP0100 system peripheral: system timer
03 PNP0b00 system peripheral: real time clock
04 PNP0303 input device: keyboard
05 PNP0f13 input device: mouse
06 PNP0c04 system peripheral: other
07 PNP0700 mass storage device: floppy
08 PNP0680 mass storage device: IDE
0d PNP0a03 bridge controller: PCI
10 PNP0c02 system peripheral: other
11 PNP0400 communications device: AT parallel port
13 PNP0501 communications device: RS-232
14 IBM0070 communications device: other
15 IBM36e1 multimedia controller: audio
19 PNP0e03 bridge controller: PCMCIA

-- 
-Justin

