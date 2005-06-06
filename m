Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFFNm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFFNm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 09:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVFFNm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 09:42:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1189 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261409AbVFFNmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 09:42:54 -0400
Date: Mon, 6 Jun 2005 15:42:53 +0200
From: Jan Kara <jack@suse.cz>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11.11 Assertion failure in journal_commit_transaction()
Message-ID: <20050606134253.GB2130@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.61.0506041304350.32405@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506041304350.32405@diagnostix.dwd.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On a busy server (dual Xeon with 4GB ram) running plain 2.6.11.11 form
> kernel.org (distribution is Fedora Core 2) I got the following error:
> 
> Jun  4 11:40:55 apollo kernel: Assertion failure in 
> journal_commit_transaction() at fs/jbd/commit.c:768: 
> "jh->b_next_transaction == ((void *)0)"
> Jun  4 11:40:55 apollo kernel: ------------[ cut here ]------------
> Jun  4 11:40:55 apollo kernel: kernel BUG at fs/jbd/commit.c:768!
> Jun  4 11:40:55 apollo kernel: invalid operand: 0000 [#1]
> Jun  4 11:45:07 apollo syslogd 1.4.1: restart.
> 
> The system bootet automatically, from the ipmi motherboard logs I can see
> that the hardware watchdog has reset the system at 11:42:55.
> It's using an ext3 on top of a software raid10 (three raid1 combined with
> raid0 over 6 SCSI disks). None of the software raids needed to rebuild after
> the crash.
> 
> Any idea why the kernel stopped? The system has been running stable for a
> year now.
  The kernel stopped because it detected a disk buffer in an unexpected
state. 2.6.12-rc5 kernel should contain some more fixes than 2.6.11.11
for similar problems so you can try that kernel. If you are able to see
the same problem with 2.6.12-rc5 then let us know please.

						Thanks for report
								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
