Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTEFD4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTEFD4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:56:08 -0400
Received: from mail.ideaone.net ([64.21.232.2]:9401 "EHLO arlene.ideaone.net")
	by vger.kernel.org with ESMTP id S262316AbTEFD4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:56:04 -0400
Subject: 2.5 neofb screen corruption leaving X
From: Reid Hekman <hekman@ideaone.net>
To: linux-kernel@vger.kernel.org
Cc: jsimmons@infradead.org
Content-Type: text/plain
Organization: 
Message-Id: <1052193973.31970.3.camel@artemis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 May 2003 23:06:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: The console is "blown up" upon leaving X with neofb
compiled in on an IBM TP600E. Characters are 2-3 times normal size, dots
are not in consecutive pixels but spaced several screen elements apart.
Lines are still spaced normally but the larger text overwrites the
previous line when they wrap. The system is still usable, but the
console is unreadable ;-) I can still go back into X just fine.

Environment: IBM Thinkpad 600E, NeoMagic 256AV, RedHat 8.0.94 (Phoebe)

lspci -v
01:00.0 VGA compatible controller: Neomagic Corporation NM2200
[MagicGraph 256AV] (rev 20) (prog-if 00 [VGA])
        Subsystem: IBM ThinkPad 570
        Flags: bus master, medium devsel, latency 128, IRQ 11
        Memory at e0000000 (32-bit, prefetchable) [size=16M]
        Memory at 70000000 (32-bit, non-prefetchable) [size=4M]
        Memory at 70400000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 1

cat /proc/cmdline 
ro root=/dev/hda2 video=neofb:1024x768-16

Kernels: Tested 2.5.67-2.5.69 and are affected, haven't gone back
further yet but I can test. RedHat 2.4.18 works correctly. 

Config is here: http://dslstatic-236-77.ideaone.net/2.5.69-config

dmesg output here: http://dslstatic-236-77.ideaone.net/kernmsg.txt

Thanks in advance,
Reid


