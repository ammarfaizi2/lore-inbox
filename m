Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVAMPuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVAMPuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVAMPsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:48:22 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:58412 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S261672AbVAMPmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:42:20 -0500
Date: Thu, 13 Jan 2005 09:42:07 -0600
From: DHollenbeck <dick@softplc.com>
Subject: Re: yenta_socket rapid fires interrupts
In-reply-to: <41E68215.8060004@suse.de>
To: Stefan Seyfried <seife@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, magnus.damm@gmail.com
Message-id: <41E696CF.6020309@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
References: <41E2BC77.2090509@softplc.com>
 <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com>
 <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
 <41E44248.2000500@softplc.com>
 <Pine.LNX.4.58.0501111322060.2373@ppc970.osdl.org> <41E68215.8060004@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Seyfried wrote:

> Linus Torvalds wrote:
>
>> What I don't see is why the port changes state, then. Since the yenta 
>> driver doesn't care for the interrupt anyway, it shouldn't be 
>> touching the hardware, and if it doesn't touch the hardware, then the 
>> pcmcia thing should eventually just calm down, even if it were to 
>> de-bounce a few times.
>>
>> The above is what you'd likely see if somebody was forcing a reset on 
>> the
>> card or a card voltage re-interrogation all the time, which I don't see
>> why it would happen.
>
>
> i have a "feeling" that a weak power supply or a little bit too high 
> current draw from the card may cause something like this. But this is 
> just what i wrote: a feeling from my stomach ;-)
>
> Stefan
>

I tested the card in a different, more beefy box, namely a shoebox PC, 
whereas the problem box is one with an external power supply coming in 
via cable. 

In the shoebox PC the card works fine.  In the shoebox, this problem 
CARDBUS card (CARDBUS to USB 2.0 adapter) is running on a PCI card, 
which is a separate "PCI to CARDBUS" PCI card.  The PCI card has a 
PCI_DEVICE_ID_RICOH_RL5C475 part, which is under control of the 
yenta_socket driver just fine.

So the "problem USB 2.0 adapter card" works OK with yenta_socket.c from 
2.6.10 on the RICOH cardbus chip.  The problem is with the TI1520 chip 
in the embedded machine on the embedded motherboard.  What we do not 
know is if the problem is with:

1) TI1520 chip/yenta combo, or
2) embedded PC/power supply

Any last gasping ideas?

Thank you all again,

Dick

