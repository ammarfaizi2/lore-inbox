Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVHKSaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVHKSaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHKSaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:30:30 -0400
Received: from mail.linicks.net ([217.204.244.146]:3591 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932347AbVHKSaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:30:30 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [lm-sensors] Re: I2C block reads with i2c-viapro: testers wanted
Date: Thu, 11 Aug 2005 19:30:27 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111930.27935.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This is a surprising result, as the VT8233 datasheet didn't mention the
>> I2C block mode. I'll add this model to the list. This also suggests that
>> the VT8233A may support it as well - if someone could test that.
>> 
>> I have to admit I don't know exactly in which order the different south
>> bridges were designed and released by VIA. I think the following order
>> is correct:
>> 
>> VT82C596
>> VT82C596B
>> VT82C686A
>> VT82C686B
>> VT8235
>> VT8237
>> 
>> But I don't know where the VT8231, VT8233 and VT8233A should be inserted
>> in this list. If anyone can tell me...
> 
> I guess it's just the way it seems:
> 
> VT82C596
> VT82C596B
> VT82C686A
> VT82C686B
> VT8231
> VT8233
> VT8233A
> VT8235
> VT8237

I have a VIA board, and remember when I config'ed I2C I was a bit confused 
with what I have - I guessed logically in the end that VT82C686 _became_ 
VT82C686A _after_ VT82C686B was released.  It all seems to work OK though.

bash-2.05b# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
22)
00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
30)
00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
78)
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
07)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 440] 
(rev a3)

I am OK for testing the patch if you need.

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
