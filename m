Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbULRHBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbULRHBI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 02:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbULRHBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 02:01:08 -0500
Received: from wasp.net.au ([203.190.192.17]:43196 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S262845AbULRHBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 02:01:05 -0500
Message-ID: <41C3D5AD.7090507@wasp.net.au>
Date: Sat, 18 Dec 2004 11:01:01 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lawyer <dave@lafn.org>
CC: Pavel Machek <pavel@suse.cz>, Park Lee <parklee_sel@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Issue on connect 2 modems with a single phone line
References: <20041215184206.43601.qmail@web51505.mail.yahoo.com> <20041216010138.GC6285@elf.ucw.cz> <20041216085828.GG1189@lafn.org>
In-Reply-To: <20041216085828.GG1189@lafn.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lawyer wrote:
> On Thu, Dec 16, 2004 at 02:01:38AM +0100, Pavel Machek wrote:
> 
>>Hi!
>>
>>
>>>  I want to try serial console in order to see the
>>>complete Linux kernel oops. 
>>>  I have 2 computers, one is a PC, and the other is a
>>>Laptop. Unfortunately,my Laptop doesn't have a serial
>>>port on it. But then, the each machine has a internal
>>>serial modem respectively.
>>>  Then, can I use a telephone line to directly connect
>>>the two machines via their internal modems (i.e. One
>>>end of the telephone line is plugged into The PC's
>>>modem, and the other end is plugged into The Laptop's
>>>modem directly), and let them do the same function as
>>>two serial ports and a null modem can do? If it is,
>>>How to achieve that?
>>
>>You'd need phone exchange to do this. Most modems will not talk using
>>simple cable. With 12V power supply and resistor phone exchange is
>>quite easy to emulate, but...
> 
> 
> Here's what I once wrote in Modem-HOWTO:
> 
>   Most modems are designed to be connected only to telephone lines and
>   will not work over just a pair of wires.  This is because the
>   telephone company supplies the telephone line with a 40-50 volt DC
>   voltage which powers part of the modem.  Recall that ordinary
>   conventional telephones are entirely powered by the voltage from the
>   telephone company.  Without such a DC voltage, the modem lacks power
>   and can't send out data.  Furthermore, the telephone company has
>   special signals indicating a ring, line busy, etc.  Conventional
>   modems expect and respond to these signals.

I have used analogue modems back to back for years and have *never* come across a modem that sourced 
anything other than it's ringing signal (via an opto) from the phone line. Every single modem I have 
here will talk to the others over a straight telephone cable.

Analogue modems use a line transformer to couple to the phone network usually with a decoupling 
capacitor on the phone end of the network to prevent large current flows through the transformer. 
They use a standard AC analogue signal. Nothing more than an audio transformer linkage.

Now, sometimes a modem needs coaxing to ignore the lack of dial/call progress tones, but they should 
always talk to each other regardless of line voltage.

ATA on one end and ATD on the other will normally get them talking.
As a test I just looped my internal AMR winmodem to my Xircom Realport V90 modem and got a solid 
28.8k link. No problem.

If the fluid is salty enough you could probably get analogue modems to talk over wet string (I have 
certainly passed RS485 over wet string before).

-- 
Brad
                    /"\
Save the Forests   \ /     ASCII RIBBON CAMPAIGN
Burn a Greenie.     X      AGAINST HTML MAIL
                    / \
