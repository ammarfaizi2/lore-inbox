Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbTJLJ5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 05:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTJLJ5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 05:57:23 -0400
Received: from smtp2.libero.it ([193.70.192.52]:49311 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S263440AbTJLJ5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 05:57:22 -0400
Date: Sun, 12 Oct 2003 11:57:20 +0200
From: Ludovico Gardenghi <garden@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: vfat corruption in 2.6.0?
Message-ID: <20031012095720.GA21405@ripieno.somiere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

A friend of mine had the same problem with 2 different test releases
(test3 and test6), and I don't know if this problem is still here as
of test7.

He has a quite big vfat partition (60 GB) created with mkfs.vfat; he
ran a program that had to write ~5000 files summing up to 18 GB but
some hour after that program started (it's a simulation tool that
runs for ~20 hours on an athlon XP 2500+) his /var started to fill with
log errors of "attempt to access beyond the end of the device".
The files are very fragmented because they are written line by line
more or less in parallel.

Moreover, the partition resulted unmountable and fsck.vfat could not
manage to repair it --- the only solution being running MS win's
scandisk tool. After the repair some of the smaller files on the disk
got lost and some part of the bigger files got corrupted.

This happened twice (with test3 and test6) and the partition was
completely erased and re-created between the 2 crashes.

I can't tell much more than this because my friend had to erase his logs
because they filled up /var.

Ludovico
-- 
<dunadan@libero.it>          #acheronte (irc.freenode.net) ICQ: 64483080
GPG ID: 07F89BB8              Jabber: garden@jabber.students.cs.unibo.it
-- This is signature nr. 1249
