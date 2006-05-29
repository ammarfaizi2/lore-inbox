Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWE2IGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWE2IGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 04:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWE2IGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 04:06:15 -0400
Received: from smtp2.actcom.co.il ([192.114.47.35]:35744 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S1750759AbWE2IGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 04:06:14 -0400
Message-ID: <003101c682ff$1b7c7350$c400a8c0@Chavalaptop>
From: "Chava Leviatan" <chavale@actcom.net.il>
To: <linux-kernel@vger.kernel.org>
Subject: Ethernet driver module compilation  (8139too)
Date: Mon, 29 May 2006 11:05:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="windows-1255";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My Linux 2.4.18 machine has 2 ethernet interfaces: eepro100 and 8139too.

I need to put a minur changes (printk messages) into those drivers, which
are loaded as kernel modules .

I first changed the eepro then  compiled it seperatly (with
_DMODULE, -D__KERNEL and the correct path into
/lib/modules/.....) and everything worked well (was able to see my printing
through dmesg).

When I tried to change 8139too, it did not work -- not because of the code
change -- rather , I had some
problems in compiling this module.
When i rebooted the machine the interfaces wer not up, and when I did lsmod
8139too was not there.
I then tried to manually install it (insmod) and was promp with unresolved
external. I found out that
those unresolved belong to mii.o which was not loaded during the boot
process.
When I changed to the original 8139too.o (luckily I have saved it ...) the
machine is ok, mii.o
is loadede , and also 8139too.

I am sure the problem is in the way I compile this module , but i don't know
what is missing ?
I have browsed many Makefiles and could not tell what flags make the
8139too.o tell the boot that
it needs mii.o . The modules.dep file create during boot tme shows that
8139too depends on mii.o,
but from some reason mii.o is ot loaded.

Maybe I can not compile kernel modules seperatly, i.e., kernel modules that
are loaded during bot time ?

Obviosly i can do this procee manually: insmod mii, then 8139 and finally
bring the interface up.
But, i really need to know what went wrong there

Any help will be much appreciated

Chava Leviatan

