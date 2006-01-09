Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWAIGKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWAIGKn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWAIGKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:10:43 -0500
Received: from lacerta.miz.nao.ac.jp ([133.40.42.170]:30873 "EHLO
	lacerta.miz.nao.ac.jp") by vger.kernel.org with ESMTP
	id S1751464AbWAIGKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:10:42 -0500
Date: Mon, 09 Jan 2006 15:10:41 +0900
From: Leonid <nouser@lpetrov.net>
Organization: 
Reply-To: Leonid <nouser@lpetrov.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Message-ID: <43C1FE61.nail8R311MEFK@lpetrov.net>
User-Agent: nail 11.6.2 (mod) 2005.07.15
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitry,

  I have the same problem. I have Dell Dimension 380 box, 
PS/2 mouse and keyboard.

  Kernel worked under 2.6.13.1 and 2.6.14 
  Then I upgraded to 2.6.15:
cp linux-2.6.14/.config linux-2.6.15/.config
cd linux-2.6.15
make oldconfig
... and usual kernel compilation ...

  Result: system is successfully booted, no error messages, loads X window,
... but both keyboard and mouse are dead: they do not respond.

  It was not the first time I have this famous problem. Last time it 
was different keyboard, different motherboard, different kernel. That time
your advice to use kernel parameter "i8042.noacpi=1" helped. This time this 
does not help. My BIOS setup has an only two choices: to enable USB controller
or to disable it. When I disable USB controller, then after booting keyboard
and mouse are working, but no USB devices work.

Configuration files:

http://lacerta.miz.nao.ac.jp/misc/config_2_6_14.txt  (2.6.14 which works)
http://lacerta.miz.nao.ac.jp/misc/config_2_6_15.txt  (2.6.15 which does not work)

Kernel messages:

http://lacerta.miz.nao.ac.jp/misc/kernel_2_6_14.txt  (2.6.14 which works)
http://lacerta.miz.nao.ac.jp/misc/kernel_2_6_15.txt  (2.6.15 which does not work)
http://lacerta.miz.nao.ac.jp/misc/kernel_2_6_15_nousb.txt  (2.6.15 with 
disabled USB controller, which works, but no USB devices are visible)

(2.6.15, kernel option i8042.noacpi=1 -- does not help)
http://lacerta.miz.nao.ac.jp/misc/kernel_2_6_15_i8042_noacpi.txt

(2.6.15, kernel option acpi=off  -- does not help)
http://lacerta.miz.nao.ac.jp/misc/kernel_2_6_15_acpi_off.txt

(2.6.15, kernel option usb-handoff -- does not help)
http://lacerta.miz.nao.ac.jp/misc/kernel_2_6_15_usb-handoff.txt

(2.6.15, kernel option i8042.debug=1 )
http://lacerta.miz.nao.ac.jp/misc/kernel_2_6_15_i8042_debug.txt
http://lacerta.miz.nao.ac.jp/misc/messages_2_6_15_i8042_debug.txt

Results of

cat /proc/acpi/dst > proc_acpi_dst.txt 
http://lacerta.miz.nao.ac.jp/misc/proc_acpi_dst.txt

Leonid
09-JAN-2006 15:07:07
