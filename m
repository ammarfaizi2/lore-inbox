Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTEXQ5S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 12:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTEXQ5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 12:57:18 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:57657 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S262263AbTEXQ5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 12:57:17 -0400
Subject: [ANN} 2.4.21-rc3-dis2 - ACPI-only laptop users, you'll like this
	one
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053796219.13531.14.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 May 2003 13:10:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick announcement, I've put together some generally-useful
patches (for laptop users mostly) that are running here without issues.

If you don't have an Inspiron 8500, (must be that exact machine) you
must read the Readme.txt and back out the custom-DSDT patch.  Otherwise,
its 'ready to go'.

2.4.21-rc2-dis1 is the most tested (ran it for almost a week,
suspended/resumed even while opengl apps were running, etc) and
2.4.21-rc3-dis2 has been running here for about 24 hours and 3 or 4
suspend/resumes without problems.  Supermount and packet writing are
untested so far (and I had build issues with packet-mode as a module.
YMMV.)

This patchset will likely never include O(1) or preempt, as they
interact badly with swsusp (it looked a lot like the earlier '[OT] I
love linux' post - mass filesystem death that recovered fine when the
journal was wiped and recreated. Not Good.)

Patches and readme at http://www.gotontheinter.net/kernel/

For -dis3 I'll probably break it into multiple patches for those people
who don't want the whole pile.  (And once -ck has swsusp this patchset
will be mostly unneeded and I may retire it, or at least base off -ck
instead of stock.)

Suggestions welcome, testers -very- welcome :) 

No CC necessary, I'm on the list..

Patches added (from 2.4.21-rc2):
  - acpi 20030512
  - acpi-swsusp 20030228-swsusp19
  - netdev-random 2.4.18-1
  - bcm4400 driver integrated (this may be bad: http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week04/0165.html ..)
  - patch-agp (for swsusp on i810)
  - orinoco-0.11b-patch for monitor mode
  - cpufreq-ck6-1.bz2
  - patch to cpufreq to allow boot-params to force initial speed
  * DIS1 released
  - 2.4.20-rc3
  - CDRW/DVD-RW packet writing mode from "007_packet_030226_ck_2.4.20.patch"
    - You'll need userspace support. http://sourceforge.net/projects/linux-udf/
  - Supermount (http://people.mandrakesoft.com/~quintela/supermount/2.4.21-pre4/)
  - O_STREAMING-rml-2.4.20-pre9-1
  - linux-2.4.13-vfat-symlink-0.90
  - trackpad-2.4.20 (optionally disable touchpad while typing, latest version)
  - touchless depends generation (for r/o source management checkouts and such)
  * DIS2 released

-- 
Disconnect <lkml@sigkill.net>

