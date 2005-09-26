Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVIZLKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVIZLKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 07:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVIZLKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 07:10:19 -0400
Received: from euklid.nt.tuwien.ac.at ([128.131.67.130]:18085 "EHLO
	euklid.nt.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1751042AbVIZLKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 07:10:18 -0400
Date: Mon, 26 Sep 2005 13:09:49 +0200
From: Stefan Froehlich <Stefan@Froehlich.Priv.at>
To: linux-kernel@vger.kernel.org
Subject: [2.6.12] cciss.o and DLT tape drives
Message-ID: <20050926110949.GA9797@euklid.nt.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an HP/Compaq ProLiant running 2.6.12 (2.6.0 before with
exactly the same behaviour) with the cciss driver (2.6.6).
HD Raid has been working fine for abount two years, but now
there is an external DLT drive. Documentation/cciss.txt instructs to
do 'echo "engage scsi" > /proc/driver/cciss/cciss0' to engage the SCSI
core. This gives me the following results during startup:

| ERROR: SCSI host `cciss' has no error handling
| ERROR: This is not a safe way to run your SCSI host
| ERROR: The error handling must be added to this driver
|  [<c02d2400>] scsi_host_alloc+0x350/0x360
|  [<c015b7fa>] do_truncate+0x4a/0x70
|  [<c02a47d4>] cciss_scsi_detect+0x24/0xc0
|  [<c02a584c>] cciss_engage_scsi+0x6c/0xb0
|  [<c02a5c90>] cciss_proc_write+0x80/0xa0
|  [<c015e970>] file_move+0x20/0x60
|  [<c015ca7c>] dentry_open+0x11c/0x260
|  [<c01703db>] locate_fd+0x6b/0xb0
|  [<c0196ca7>] proc_file_write+0x37/0x50
|  [<c015d9ae>] vfs_write+0xae/0x130
|  [<c015db01>] sys_write+0x51/0x80
|  [<c0102f45>] syscall_call+0x7/0xb
| scsi0 : cciss
|   Vendor: QUANTUM   Model: DLT VS160         Rev: 2500
|   Type:   Sequential-Access                  ANSI SCSI revision: 02
| Attached scsi tape st0 at scsi0, channel 0, id 0, lun 0
| st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 4294967295
|Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 1

I deliberately decided to ignore this (the tape seemed to be fine at the
first glance), which was probably not the best idea, as the machine is
now crashing quite hard every few days. So: if "this" is not a safe way
to run my SCSI host, which way would be better?

(I don't have any further information about the crashes - there is no
easy physical access to it for me, and the logfiles don't report
anything abnormal - most likely due to the fact, that the controller
won't be able to write any more)

Bye,
  Stefan

-- 
http://kontaktinser.at/ - kostenlose Kontaktanzeigen fuer Österreich

Himmlisch bleibt himmlisch: Stefan braucht diese Welt!
(Sloganizer)
