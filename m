Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTDDSkh (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbTDDSkh (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:40:37 -0500
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:58858 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id S263880AbTDDSkf (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 13:40:35 -0500
From: "Dave Wickham" <dave@aagames.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Framebuffer problems (like Mike Tangolics' problems)
Date: Fri, 4 Apr 2003 19:51:03 +0100
Message-ID: <GMEMJKBDFLJMOHPJLOAEIEGFCFAA.dave@aagames.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I appear to have the same problem as Mike Tangolics does using stock 
2.5.66 and 2.4.20 kernels. Using the exact same LILO config as I do on a 
2.4.18 kernel (the default Slackware 8.1 precompiled version, if that 
makes any difference), the display is blank (every time). Everything has
started, as I can still SSH into the machine. .config files are 
available on request, and below is my lilo.conf file (with unneeded stuff
 - e.g. comments - stripped out).

--lilo.conf
boot = /dev/hda
message = /boot/boot_message.txt
prompt
timeout = 1200
change-rules
  reset
vga = 773
image = /boot/devlinx
  root = /dev/hda4
  label = Linux-DEV
  read-only
image = /boot/gcc3linux
  root = /dev/hda4
  label = Linux
  read-only
image = /boot/vmlinuz
  root = /dev/hda4
  label = Linux-OLD
  read-only
--end lilo.conf

Linux-OLD boots perfectly in this case, but Linux-DEV and Linux don't
give any "video" (e.g. startup information).
I tried the suggestion given by Matthew Hall, but that made no 
difference.

I'm using an nVidia GeForce 2MX 32MB. 

--
Dave Wickham
Yes, I'm using Microsoft Outlook until I get my XFree86 compiled again.
