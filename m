Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279652AbRKAUBH>; Thu, 1 Nov 2001 15:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279650AbRKAUA5>; Thu, 1 Nov 2001 15:00:57 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:2579 "HELO abasin.nj.nec.com")
	by vger.kernel.org with SMTP id <S279648AbRKAUAt>;
	Thu, 1 Nov 2001 15:00:49 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15329.43498.436892.985755@abasin.nj.nec.com>
Date: Thu, 1 Nov 2001 15:00:42 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: Google's mm problems with 2.4.13 and 4G of memory
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin>
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got a Dell powerEdge something with 4G of memory locking up pritty
hard when Danial Phillips test program hits chunk 9:

mlocking at 401bf000 of size 1048576
mlock took 12.181794 seconds
munlock'ed 5999e000
munmap'ed 5999e000
Loading data at 5999e000 for slot 1
Load (/mnt/sdb/sven/chunk9) succeeded!
mlocking slot 1, 5999e000
mlocking at 5999e000 of size 1048576


And nothing.  It's a vanilla 2.4.13 kernel and Mandrake 8.0.

If I run the program up to like chunk 3 and send an interrupt it
doesn't free up the memory unless I umount the file system.

Please suggest idea on how to fix it.  I have this system to abuse for
several days.

      Sven
