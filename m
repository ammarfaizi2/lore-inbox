Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310506AbSCCFYM>; Sun, 3 Mar 2002 00:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310504AbSCCFYD>; Sun, 3 Mar 2002 00:24:03 -0500
Received: from konza.flinthills.com ([64.39.200.1]:13030 "EHLO
	konza.flinthills.com") by vger.kernel.org with ESMTP
	id <S310512AbSCCFXy>; Sun, 3 Mar 2002 00:23:54 -0500
Date: Sat, 2 Mar 2002 23:22:33 -0600 (CST)
From: Derek J Witt <cappicard@flinthills.com>
To: linux-kernel@vger.kernel.org
cc: Derek Witt <djw@flinthills.com>
Subject: Re: hdc: lost interrupt
In-Reply-To: <20020303050340Z293053-889+116534@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0203022321470.5556-120000@saiya-jin.flinthills.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; REPORT-TYPE=delivery-status; BOUNDARY="S293053AbSCCFD3=_/vger.kernel.org"
Content-ID: <Pine.LNX.4.44.0203022321471.5556@saiya-jin.flinthills.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--S293053AbSCCFD3=_/vger.kernel.org
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0203022321472.5556@saiya-jin.flinthills.com>


--S293053AbSCCFD3=_/vger.kernel.org
Content-Type: MESSAGE/DELIVERY-STATUS; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0203022321473.5556@saiya-jin.flinthills.com>
Content-Description: 

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Sun, 3 Mar 2002 00:03:12 -0500
Local-Spool-ID: S292385AbSCCFDM

Original-Recipient: rfc822;lknl@vger.kernel.org
Final-Recipient: RFC822;lknl@vger.kernel.org
Action: failed
Status: 5.1.1 (User does not exist)
Last-Attempt-Date: Sun, 3 Mar 2002 00:03:29 -0500
Diagnostic-Code: x-local; 550 (User does not exist)

--S293053AbSCCFD3=_/vger.kernel.org
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0203022321474.5556@saiya-jin.flinthills.com>
Content-Description: 

Received: from konza.flinthills.com ([64.39.200.1]:28131 "EHLO
	konza.flinthills.com") by vger.kernel.org with ESMTP
	id <S292385AbSCCFDM>; Sun, 3 Mar 2002 00:03:12 -0500
Received: from saiya-jin.flinthills.com (mail@saiya-jin.flinthills.com [64.39.192.211])
	by konza.flinthills.com (8.12.0.Beta7/8.12.0.Beta7) with ESMTP id g2353BCc026343
	for <lknl@vger.kernel.org>; Sat, 2 Mar 2002 23:03:11 -0600 (CST)
Received: from localhost ([127.0.0.1] ident=cappicard)
	by saiya-jin.flinthills.com with esmtp (Exim 3.34 #1 (Debian))
	id 16hO88-0001Ld-00
	for <lknl@vger.kernel.org>; Sat, 02 Mar 2002 23:01:52 -0600
Date: Sat, 2 Mar 2002 23:01:52 -0600 (CST)
From: Derek J Witt <djw@flinthills.com>
X-X-Sender: cappicard@saiya-jin.flinthills.com
Reply-To: Derek J Witt <djw@flinthills.com>
To: lknl@vger.kernel.org
Subject: Re: hdc: lost interrupt
Message-ID: <Pine.LNX.4.44.0203022235100.4998-100000@saiya-jin.flinthills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII

I just solved my lost interrupt problems. I just moved my Caviar hard
drive from secondary master to primary slave. and I've not received any
lost interupt errors. But I may just recompile my kernel without apic. I
also have an SMP-capable controller that is also used for the sensor. But,
I know I don't need an apic for the sensor to run.

(I wonder if the apic is throwing off my LM80's readings. That's a
different matter.)

>
>> yeah, I am. My celeron 500 PPGA has APIC. Oh, could the apic causing
>> interrupt timing problems?
>
>yes, that's the point.  windows doesn't use the local apic,
>so a lot of bioses don't configure it properly.  note that it
>offers only fairly obscure benefits (nmi oopser, perf-counter events);
>in particular, the local apic is probably *slower* than normal pic.
>
>
>
>
>
>> On Sat, 2002-03-02 at 10:16, Mark Hahn wrote:
>> > > losing IDE interrupts.  I tried disabling multimode in makeconfig but to
>> >
>> > are you using the local apic?
>> >
>> > here are the set settings I use on my via-based machines (which are all stable):
>> > CONFIG_IDE=y
>> > CONFIG_BLK_DEV_IDE=y
>> > CONFIG_BLK_DEV_IDEDISK=y
>> > CONFIG_IDEDISK_MULTI_MODE=y
>> > CONFIG_BLK_DEV_IDECD=y
>> > CONFIG_BLK_DEV_IDEPCI=y
>> > CONFIG_IDEPCI_SHARE_IRQ=y
>> > CONFIG_BLK_DEV_IDEDMA_PCI=y
>> > CONFIG_BLK_DEV_ADMA=y
>> > CONFIG_IDEDMA_PCI_AUTO=y
>> > CONFIG_BLK_DEV_IDEDMA=y
>> > CONFIG_BLK_DEV_VIA82CXXX=y
>> > CONFIG_IDEDMA_AUTO=y
>> > CONFIG_BLK_DEV_IDE_MODES=y
>> >
>> > > Has anyone else with a Via chipset been able to boot into 2.5.x without having these interrupt problems? Any suggestions will be helpful.
>> >
>> > I confess I haven't ventured to use 2.5 on any machines.
>> >
>> >
>>
>
>--
>operator may differ from spokesperson.	            hahn@coffee.mcmaster.ca
>                                              http://java.mcmaster.ca/~hahn


**  Derek J Witt                                              **
*   Email: mailto:djw@flinthills.com                           *
*   Home Page: http://www.flinthills.com/~djw/                 *
*** "...and on the eighth day, God met Bill Gates." - Unknown **


--S293053AbSCCFD3=_/vger.kernel.org--
