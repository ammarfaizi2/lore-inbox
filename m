Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTGKP0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTGKP0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:26:47 -0400
Received: from f25.mail.ru ([194.67.57.151]:60173 "EHLO f25.mail.ru")
	by vger.kernel.org with ESMTP id S263398AbTGKP0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:26:22 -0400
From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
To: =?koi8-r?Q?=22?=Oleg Drokin=?koi8-r?Q?=22=20?= <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: 2.4.22-pre3 and reiserfs problem (not boot)
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [81.89.69.194]
Date: Fri, 11 Jul 2003 19:41:03 +0400
In-Reply-To: <20030711142914.GB24682@namesys.com>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= 
	  <ia6432@inbox.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19b019-000Grz-00.ia6432-inbox-ru@f25.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> There was one more reiserfs message in kernel log just before this
> line, can you please include it?
> 
> > Jul 10 06:25:41 host kernel: kernel BUG at prints.c:334!
> > Jul 10 06:25:41 host kernel: invalid operand: 0000
> > Jul 10 06:25:41 host kernel: CPU:    1
> > Jul 10 06:25:41 host kernel: EIP:    0010:[reiserfs_panic+41/96]    Not tainted

right. ksymoops cut it out so i missed it.

Jul 10 06:25:10 host kernel: journal-601, buffer write failed

another thing to note, both oopses happend exactly at 06:25:41 (Jul 10 and 11), and both times there were "journal-601, buffer write failed"
close prior to it.

i missed a lot info in original message, sorry.
here it is:

the box is dual p3, serverworks le chipset, 1gb memory, integrated
dual-channel adaptec 7899a, intel e1000, 4 scsi disks, scsi promise
ide-raid box attached.

local disks form md0 with raid5 with total size of ~130gb.
promise box also in raid5 mode with total size of ~1.3tb.
both use reiserfs.

in the logs we often get messages like:
Jul 11 14:25:59 host kernel: (scsi0:A:10:0): parity error detected in Data-out phase. SEQADDR(0x55) SCSIRATE(0xc2)
Jul 11 14:25:59 host kernel: ^INo terminal CRC packet recevied

_but_ with 2.4.21-rc? kernel it cause no problems and no data loss.
promise box itself doesn't detect any errors.
i've checked the list and found coule of messages about such "parity
errors" in recent kernels, but no solution or any info about it
causing problems.
hoping to get rid of this messages i've tried 2.4.22-pre3 and got
oopses...


