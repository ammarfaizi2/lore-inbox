Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWBWXsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWBWXsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWBWXsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:48:38 -0500
Received: from web34308.mail.mud.yahoo.com ([66.163.178.140]:33385 "HELO
	web34308.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932136AbWBWXsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:48:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TSODrLLYVSJvhUnGkSm7TcZJHVXQTRLTXlnwBgE1imH7BZfAbnEguC6BAfRy7eVXRQUEp8f/pEbwqaHfJ+VZCrYjuJDlCeU4twvD3dy+dc9bAGJoAY6NuG6NOLmlAiRfd1a4KBIRRVBG25fc8bcRvSeCWsdRFOvP6fCwgFkuQ4Y=  ;
Message-ID: <20060223234835.40136.qmail@web34308.mail.mud.yahoo.com>
Date: Thu, 23 Feb 2006 15:48:35 -0800 (PST)
From: Jin Suh <jinssuh@yahoo.com>
Subject: 2.6.15 is having difficulty handling bad blocks
To: linux-kernel@vger.kernel.org
Cc: CP Pluhar <cp@pluhar.net>, Brian Ling <bc@ling.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a following report dealing with bad blocks. Any help would be
appreciated.

2.6.15 is having difficulty handling bad blocks. Numerous tests on 2 different
drives with bad blocks have resulted in either the imaging or verify process
failing, or (on one of the drives tested) a kernel panic, when the process hits
the bad blocks. System messages show typical error messages followed by an "hde
lost interrupt" error when the process fails.

The problem is somewhat inconsistent as one of the drives tested did properly
pad the bad blocks and complete the process.

Testing of the same drives with same commands with the Linux 2.4.29-rc1 show
that it handles the bad blocks properly, padding as desired.

Testing on the class FC4 install (2.6.14-1.1656_FC4i1smp), with the same dcfldd
command as the boot CD, results in the same failed behavior.

Varying the block size (512 and 1024) has no apparent effect, process still
fails on bad blocks.

dd_rescue also tested with the same failed result

Drives tested:

WD WD100 10 GB, LBA 19541088, s/n:WMA6K3772662 - imaging and verifying
processes failed when encountering bad blocks

WD WDC AC2540H 540 MB, LBA 1056384, s/n: WD-WT2610005691 - imaging and
verifying processes completed (padded bad blocks)

Seagate ST36451A 6448 MB, LBA 12594960, s/n: JG297669 - imaging and verifying
processes failed when encountering bad blocks



