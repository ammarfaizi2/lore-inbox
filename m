Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWAOWVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWAOWVS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWAOWVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 17:21:18 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:61390 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750936AbWAOWVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 17:21:18 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sun, 15 Jan 2006 23:21:13 +0100
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: Re: spurious 8259A interrupt: IRQ7
In-reply-to: <Pine.LNX.4.61.0601152211150.29696@yvahk01.tjqt.qr>
References: <20060115172118.A9CE622B38F@anxur.fi.muni.cz>
Message-Id: <20060115222111.664DB22B379@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>  0:     367164          XT-PIC  timer
>
>>>01:05.0 VGA compatible controller: ATI Technologies Inc RS300M AGP [Radeon Mobility 9100IGP] (prog-if 00 [VGA])
>>>        Subsystem: ASUSTeK Computer Inc.: Unknown device 1902
>
>You seem to have APIC disabled?
Nope. There are also lines
LOC:     367136
and
MIS:          0
which are printed only with (io)apic enabled.

$ dmesg|grep -i apic
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
$ grep APIC config 
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

dmesg and config are here (I forgot to attach before):
http://www.fi.muni.cz/~xslaby/sklad/{dmesg,config}

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
