Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSCGAiX>; Wed, 6 Mar 2002 19:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288958AbSCGAiN>; Wed, 6 Mar 2002 19:38:13 -0500
Received: from mail.webmaster.com ([216.152.64.131]:55985 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S288914AbSCGAiK> convert rfc822-to-8bit; Wed, 6 Mar 2002 19:38:10 -0500
From: David Schwartz <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Wed, 6 Mar 2002 16:38:06 -0800
Subject: atkbd works as module but not linked in, 2.5.5-dj3
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020307003808.AAA19282@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	This is a strange problem. I have CONFIG_KEYBOARD_AT set, and my System.map 
file has the correct entries to show that the atkbd.c file was linked into my 
kernel. Yet my AT keyboard is not detected. 'dmesg' shows:

 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 >
mice: PS/2 mouse device common for all mice
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
NET4: Linux TCP/IP 1.0 for NET4.0

	Now here's the strange part -- if I manually compile atkbd.c as a module and 
'insmod' it, this appears:

input: AT Set 2 keyboard on isa0060/serio0

	And then the keyboard works. Am I doing something wrong? Everything worked 
fine with 2.5.5-dj1, I have not tested 2.5.5-dj2 but would be glad to do so 
if anyone thought it might help.

	System is a dual p3-750, 440BX chipset. I'm going to keep looking into it, 
checking the code that should initialize the keyboard and also looking at the 
diffs closely.

-- 
David Schwartz
<davids@webmaster.com>


