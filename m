Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314016AbSDKKVM>; Thu, 11 Apr 2002 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314017AbSDKKVL>; Thu, 11 Apr 2002 06:21:11 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:32694 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S314016AbSDKKVK> convert rfc822-to-8bit; Thu, 11 Apr 2002 06:21:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gabor Kerenyi <wom@tateyama.hu>
To: Paratimer@aol.com, EdV@macrolink.com
Subject: Re: [PLX-9050] Re: how to write driver for PCI cards
Date: Thu, 11 Apr 2002 19:19:21 +0900
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e5.168693d9.29e6a308@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204111919.21901.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 April 2002 17:27, Paratimer@aol.com wrote:
> In a message dated 4/11/2002 12:48:12 AM Eastern Daylight Time,
>
> wom@tateyama.hu writes:
> > Yes it is  a PLX-9050. The device uses interrupts, but why should I have
> > to know that what type of interrupt it is? Until now I haven't found
> > anything describing it.
> > I could find out from the docs that it uses memory I/O and everything is
> > done
> > through a 8K buffer.
>
> As I remember the serial eeprom from which the PLX-9050 is configured
> needs to be programmed differently according to the type of interrupt.

I think the device is configured properly because a windows driver exists and 
it's working correctly. But what do I have to do on the driver side according 
to the type of the interrupt? Is there any difference from the driver's point 
if view?
Both needs the interrupt flag to be cleared.

> But more important, I do not believe your company wants to use the
> 9050 in a cPCI system.  This chip does not support hot swappabilitiy.
> I believe there is an almost identical part, the PLX 9051 (or perhaps the
> 9052) that does.  You might have the hardware engineer check the
> issue out.

The company uses the 9050 in a C-PCI system. The card is designed in 98 or 99. 
So the card is produced and there are existing products using it. (of course 
these are only windows based). But thanks for the info, I will mention the 
hot swapable problem using the 9050. But I think this feature is delayed at 
least until I develop the driver.
I suggested already to implement this feature in the driver if the hw supports 
it but they couldn't tell me whether it supports.

Gabor

