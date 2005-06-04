Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVFDNZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVFDNZi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 09:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVFDNZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 09:25:38 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:33968 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S261345AbVFDNZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 09:25:31 -0400
Date: Sat, 4 Jun 2005 13:25:20 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.11.11 Assertion failure in journal_commit_transaction()
Message-ID: <Pine.LNX.4.61.0506041304350.32405@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On a busy server (dual Xeon with 4GB ram) running plain 2.6.11.11 form
kernel.org (distribution is Fedora Core 2) I got the following error:

Jun  4 11:40:55 apollo kernel: Assertion failure in journal_commit_transaction() at fs/jbd/commit.c:768: "jh->b_next_transaction == ((void *)0)"
Jun  4 11:40:55 apollo kernel: ------------[ cut here ]------------
Jun  4 11:40:55 apollo kernel: kernel BUG at fs/jbd/commit.c:768!
Jun  4 11:40:55 apollo kernel: invalid operand: 0000 [#1]
Jun  4 11:45:07 apollo syslogd 1.4.1: restart.

The system bootet automatically, from the ipmi motherboard logs I can see
that the hardware watchdog has reset the system at 11:42:55.
It's using an ext3 on top of a software raid10 (three raid1 combined with
raid0 over 6 SCSI disks). None of the software raids needed to rebuild after
the crash.

Any idea why the kernel stopped? The system has been running stable for a
year now.

If I forgot any information please ask so I can provide them.

Thanks,
Holger
-- 

