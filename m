Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264279AbUFHT4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbUFHT4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 15:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbUFHT4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 15:56:20 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:44929 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264279AbUFHT4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 15:56:14 -0400
Date: Tue, 8 Jun 2004 21:56:10 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: shaggy@austin.ibm.com
Subject: Linux 2.4.26 JFS: cannot mount
Message-ID: <20040608195610.GA4757@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	shaggy@austin.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a FYI bugreport. I acknowledge it doesn't contain useful
information for debugging, but in case there have already been related
reports, it may still be useful:

I recently had a mount failure for a jfs file system at boot-up, mount
complained about bad options or superblock, but no messages were stuffed
in dmesg.

Running fsck.jfs /dev/hda6 without further argument fixed this problem,
after fsck.jfs, I could mount the file system normally.
(fsck.jfs version 1.1.1, 17-Dec-2002)

Vanilla 2.4.26 kernel on SuSE Linux 8.2.

I haven't found any useful logs and didn't bother to dump the broken
file system image to tape or something because it struck a production
machine that needed to be brought back up quickly.

It is exported via NFS v2 and NFS v3 to Linux/x86 and Solaris 8/sparc64
clients.

The problematic file system was on an IBM IC35L060AVV207-0 drive that
was running with write cache switched off, it is an Athlon-XP 1700+
machine with 512 MB RAM and a VIA KT333 chip set that has been solid for
a long time.

The reboot that showed the mount error had been triggered by watchdog
that wasn't too happy that syslogd wasn't writing to /var/log/messages
(which was 2 GB sized after a looping process filled the disk)

Thanks for your attention,

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95
