Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264078AbTFDVBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264081AbTFDVBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:01:12 -0400
Received: from adsl-64-166-42-134.dsl.scrm01.pacbell.net ([64.166.42.134]:51716
	"HELO www.wavicle.org") by vger.kernel.org with SMTP
	id S264078AbTFDVBL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:01:11 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Joe Burks <jburks@wavicle.org>
To: linux-kernel@vger.kernel.org
Subject: Why am I getting Kernel Panic VFS cannot mount root fs on 301?
Date: Wed, 4 Jun 2003 14:14:39 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306041412.27897.jburks@wavicle.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately I cannot copy the exact text I'm getting, but it is something 
similar to that.  Now that I have time again, I desperately need to maintain 
drivers/usb/media/vicam.c again and am trying to boot 2.5.70 to do so.  
Here's what I've tried:

Freshly installed debian woody
Freshly downloaded 2.5.70
Downloaded, compiled and installed init-module-utils 0.9.12 from Rusty's site.
Downloaded, compiled and installed latest devfsd (although it currently does 
not seem to get to a point where this would matter, it never mounts the root 
fs in order to start devfsd)
Carefully followed instructions in Documentation/filesystems/devfs/README on 
setting up devfs for the impatient.
Configured kernel, including enabling devfs and devfs_mount.
make bzImage modules modules_install install (not in one line, one at  a time)
went into lilo.conf and added an append="root=<device>" line, then re-ran 
lilo.  (where I say <device> I have tried about 100 different possibilities 
ranging from easy ones like /dev/hda1 or /dev/discs/disc0/part1 to 
/dev/ide/...)  Obviously I only get the "301" error when the root= line is 
missing and I let lilo write that magic value.

No matter what root= line I supplied it just wouldn't boot.  I've also tried 
devfs=mount, devfs=nomount all to no solution.  So in frustration I rebuilt 
the kernel without devfs, since I figured that is where my problem was, but 
the exact error is still occurring.  I tried both leaving in a root= and 
removing the root= append line with devfs not installed.

I can still boot fine with whichever kernel woody installed (2.4.16 I think).

I don't think this is a devfs problem.  I think there is some subtle (or maybe 
blatantly obvious) kernel option I have not checked which would cause the 
whole situation to go away.

Does anybody know what this option is?

Thanks
-Joe
