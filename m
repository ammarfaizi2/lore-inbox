Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLSUiW>; Tue, 19 Dec 2000 15:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbQLSUiM>; Tue, 19 Dec 2000 15:38:12 -0500
Received: from femail10.sdc1.sfba.home.com ([24.0.95.106]:58332 "EHLO
	femail10.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129228AbQLSUiC>; Tue, 19 Dec 2000 15:38:02 -0500
Date: Tue, 19 Dec 2000 15:07:23 -0500
From: Ari Pollak <compwiz@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: NFS Locking problems
Message-ID: <20001219150723.A4155@darth.ns>
Mail-Followup-To: Ari Pollak <compwiz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux darth.ns 2.4.0-test12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a problem with NFS locking in 2.4.0-test12 and/or 2.2.18? I'm
using nfs-utils 0.2.1 and NFS v2, connected to a NFS v2 server running
Linux 2.2.18. Whenever mutt tried to place a lock on a file on an NFS
share, I get the following messages in syslog (I get the same message
for each time mutt tried to lock a file):

Dec 19 20:00:39 darth rpc.statd[558]: gethostbyname error for darth.ns
Dec 19 20:00:39 darth rpc.statd[558]: STAT_FAIL to darth.ns for SM_MON
of 192.168.1.1
Dec 19 15:00:39 darth kernel: lockd: cannot monitor 192.168.1.1

darth.ns is the system I have NFS mounted on, and 192.168.1.1 is the NFS
server. On a side note, I have no idea why rpc.statd is reporting 20:00
as the time and kernel is reporting 15:00, but the messages are right
after another in the order you see.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
