Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbSKLRVf>; Tue, 12 Nov 2002 12:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266679AbSKLRVf>; Tue, 12 Nov 2002 12:21:35 -0500
Received: from p50847562.dip.t-dialin.net ([80.132.117.98]:57295 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP
	id <S266678AbSKLRVc>; Tue, 12 Nov 2002 12:21:32 -0500
Date: Tue, 12 Nov 2002 18:28:21 +0100
From: Matthias Urlichs <smurf@noris.de>
To: linux-kernel@vger.kernel.org
Subject: PATCH 2.4: scsi and BLK_STATS
Message-ID: <20021112172821.GA14195@play.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people might want SCSI without block statistics...

This BitKeeper patch contains the following changesets:
+

# This is a BitKeeper patch.  What follows are the unified diffs for the
# set of deltas contained in the patch.  The rest of the patch, the part
# that BitKeeper cares about, is below these diffs.
# User:	smurf
# Host:	play.smurf.noris.de
# Root:	/smurf/src/kernel/linux-2.4

#
#--- 1.15/drivers/scsi/scsi_lib.c	Tue Aug 13 15:35:17 2002
#+++ 1.16/drivers/scsi/scsi_lib.c	Tue Nov 12 18:25:40 2002
#@@ -422,7 +422,9 @@
# 		complete(req->waiting);
# 
# 	spin_lock_irqsave(&io_request_lock, flags);
#+#ifdef CONFIG_BLK_STATS
# 	req_finished_io(req);
#+#endif
# 	spin_unlock_irqrestore(&io_request_lock, flags);
# 
# 	add_blkdev_randomness(MAJOR(req->rq_dev));
#

# Diff checksum=c1ec73f8


# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
jgarzik@redhat.com|ChangeSet|20021108164427|64723
D 1.782 02/11/12 18:26:07+01:00 smurf@play.smurf.noris.de +3 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c drivers/scsi/scsi_lib.c:
c 	req_finished_io is only available with CONFIG_BLK_STATS
K 4248
P ChangeSet
------------------------------------------------

0a0
> torvalds@athlon.transmeta.com|drivers/scsi/scsi_lib.c|20020205174009|30670|f55fe1364a50eb99 smurf@play.smurf.noris.de|drivers/scsi/scsi_lib.c|20021112172540|62915
> torvalds@athlon.transmeta.com|drivers/scsi/sim710_u.h|20020205174009|26761|983dda40b0d929f6 smurf@play.smurf.noris.de|BitKeeper/deleted/.del-sim710_u.h~983dda40b0d929f6|20021111023741|24738
> torvalds@athlon.transmeta.com|drivers/scsi/sim710_d.h|20020205174009|26007|66a7a0873b750aa9 smurf@play.smurf.noris.de|BitKeeper/deleted/.del-sim710_d.h~66a7a0873b750aa9|20021111023741|03935

== drivers/scsi/scsi_lib.c ==
torvalds@athlon.transmeta.com|drivers/scsi/scsi_lib.c|20020205174009|30670|f55fe1364a50eb99
alan@lxorguk.ukuu.org.uk|drivers/scsi/scsi_lib.c|20020814030503|60521
D 1.16 02/11/12 18:25:40+01:00 smurf@play.smurf.noris.de +2 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c req_finished_io is only available with CONFIG_BLK_STATS
K 62915
O -rw-rw-r--
P drivers/scsi/scsi_lib.c
------------------------------------------------

I424 1
#ifdef CONFIG_BLK_STATS
I425 1
#endif

== BitKeeper/deleted/.del-sim710_d.h~66a7a0873b750aa9 ==
torvalds@athlon.transmeta.com|drivers/scsi/sim710_d.h|20020205174009|26007|66a7a0873b750aa9
rhirst@linuxcare.com|drivers/scsi/sim710_d.h|20020528220443|60714
D 1.3 02/11/11 03:37:41+01:00 smurf@play.smurf.noris.de +0 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Delete: drivers/scsi/sim710_d.h
K 3935
O -rw-rw-r--
P BitKeeper/deleted/.del-sim710_d.h~66a7a0873b750aa9
------------------------------------------------


== BitKeeper/deleted/.del-sim710_u.h~983dda40b0d929f6 ==
torvalds@athlon.transmeta.com|drivers/scsi/sim710_u.h|20020205174009|26761|983dda40b0d929f6
rhirst@linuxcare.com|drivers/scsi/sim710_u.h|20020528220443|09958
D 1.3 02/11/11 03:37:41+01:00 smurf@play.smurf.noris.de +0 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Delete: drivers/scsi/sim710_u.h
K 24738
O -rw-rw-r--
P BitKeeper/deleted/.del-sim710_u.h~983dda40b0d929f6
------------------------------------------------


# Patch checksum=ca3c169d
