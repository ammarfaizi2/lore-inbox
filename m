Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312588AbSDKRRD>; Thu, 11 Apr 2002 13:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312604AbSDKRRC>; Thu, 11 Apr 2002 13:17:02 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:34572 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S312588AbSDKRRC>; Thu, 11 Apr 2002 13:17:02 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7775@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Gabor Kerenyi'" <wom@tateyama.hu>
Cc: linux-kernel@vger.kernel.org, Paratimer@aol.com
Subject: RE: [PLX-9050] Re: how to write driver for PCI cards
Date: Thu, 11 Apr 2002 10:16:57 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabor,

Gabor Kerenyi wrote:
> Paratimer@aol.com wrote:
> > As I remember the serial eeprom from which the PLX-9050 is 
> > configured needs to be programmed differently according to 
> > the type of interrupt.
> 
> I think the device is configured properly because a windows 
> driver exists and it's working correctly. But what do I have 
> to do on the driver side according to the type of the interrupt? 
> Is there any difference from the driver's point of view? 

I was thinking about driver programming of a device on the board that sends
interrupt requests to the PLX-9050. I got bit by a UART that powered on to
an 
interrupt signaling mode that caused the 9050 to continuously assert an 
interrupt request on the PCI bus. This was not a 9050 setup issue. I hope 
that your board does not have any issues like that. 

> > But more important, I do not believe your company wants to 
> > use the 9050 in a cPCI system.  This chip does not support 
> > hot swappability. I believe there is an almost identical part, 
> > the PLX 9051 (or perhaps the 9052) that does.  You might have 
> > the hardware engineer check the issue out.
> 
> The company uses the 9050 in a C-PCI system. The card is designed 
> in 98 or 99. 

When we updated our 9050 based card for hot-swap, we selected the PLX-9030 
which is a compatible, but newer, part. It incorporates all of the CPCI 
hot-swap infrastructure, even small stuff like ejector switch debouncing. 

Regards,
Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

