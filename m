Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbSIRWhx>; Wed, 18 Sep 2002 18:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269378AbSIRWhx>; Wed, 18 Sep 2002 18:37:53 -0400
Received: from s383.jpl.nasa.gov ([137.78.170.215]:41386 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S269372AbSIRWhw>; Wed, 18 Sep 2002 18:37:52 -0400
Message-ID: <3D890169.8090702@jpl.nasa.gov>
Date: Wed, 18 Sep 2002 15:42:49 -0700
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 hard lock problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a kernel that hard locks when doing fast NFS and scsi.
the last message from the kernel is:
kernel: (scsi0:A:0:0): Locking max tag count at 64

scsi driver is aic7xxx, nfs is client using tcp and v3. HIGHMEM is on,
when using a kernel configured the same exact way with HIGHMEM off there
is no locking up.

The kernel is not a plain kernel, it's a vendor kernel from Mandrake.
But they don't seem to know what's up. If I need to hand build a kernel
from you guys to help debug, let me know!! :)

further info:
At the consol (no X is running and it's not tainted) I can use the sysrq
keys but they will just further hard lock the kernel so it won't even
respond to the keyboard. I can't get a process list, syncing the disks,
or if I try to get memory stats all result in the kernel being totally
deadlocked.

if you have any other sysrq combo's or any other idea's to try, please 
le mw know! I'm willing to patch, rebuild, patch again till a fix is found.


-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov


