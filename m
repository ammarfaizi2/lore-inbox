Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277937AbRJITlO>; Tue, 9 Oct 2001 15:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277936AbRJITlF>; Tue, 9 Oct 2001 15:41:05 -0400
Received: from mail.spylog.com ([194.67.35.220]:30389 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S277931AbRJITku>;
	Tue, 9 Oct 2001 15:40:50 -0400
Date: Tue, 9 Oct 2001 23:37:19 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <8371332758.20011009233719@spylog.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, admin@spylog.com
Subject: Re[2]: RAID sync
In-Reply-To: <15298.13864.971940.46509@notabene.cse.unsw.edu.au>
In-Reply-To: <1101445461994.20011001182753@spylog.com>
 <15298.13864.971940.46509@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, Neil,

Tuesday, October 09, 2001, 3:26:32 AM, you wrote:

>>         Kernel 2.4.6.SuSE-4GB-SMP, 2 CPU, 2Gb RAM, 4 HDD SCSI, M/B Intel L440GX.
>> Messages from dmesg:
NB> snip
>> md: now!
>> md: sdb2's event counter: 0000001c
>> md: sda2's event counter: 0000001d
NB> snip
>>         Why RAID do not start synchronization ? It is normal ?

NB> Yes.
NB> A difference of 1 in the event counters isn't considered enough to
NB> treat on of them as old, and presumably the newest one (sda2) was
NB> marked clean.
NB> This could happen if the array was shut down cleanly, the new super
NB> block (with the dirty bit cleared) was written to sda2, but the new
NB> superblock was NOT written to sdb2 for some reason.  In this situation
NB> there is no need to resync the array.

NB> Could this be what happened in your case?

        Server  is  slow  die  (error in VM, server lost procfs) and rebooted by
'reboot -f'... I don't know what happen with RAID in this case.

NB> NeilBrown

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

