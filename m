Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbSIPWtx>; Mon, 16 Sep 2002 18:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbSIPWtx>; Mon, 16 Sep 2002 18:49:53 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:2688 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263285AbSIPWtv>; Mon, 16 Sep 2002 18:49:51 -0400
Date: Mon, 16 Sep 2002 16:54:48 -0600
Message-Id: <200209162254.g8GMsmG00784@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Subject: [BUG] NFS in 2.4.20-pre6+ stalls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Just noticed this with 2.4.20-pre6 (and -pre7): NFS write
sometimes (usually) stalls for minutes at a time. This problem wasn't
there on 2.4.19. I've noticed this when writing a files around 1 MiB
or so (some a bit larger, some a bit smaller). It makes NFS almost
unusable. I've appended the kernel logs which come, at no extra
charge, with the problem. On the server, I see partial files (integral
number of wsize= blocks) during the stall. Eventually, the client
seems to recover and the rest of the file is written. The writing
application is in TASK_INTERRUPTIBLE state.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
===============================================================================
nfs: task 125 can't get a request slot
nfs: task 126 can't get a request slot
nfs: task 127 can't get a request slot
nfs: task 128 can't get a request slot
nfs: task 129 can't get a request slot
nfs: task 130 can't get a request slot
nfs: task 131 can't get a request slot
nfs: task 132 can't get a request slot
nfs: task 133 can't get a request slot
nfs: task 134 can't get a request slot
nfs: task 135 can't get a request slot
nfs: task 136 can't get a request slot
nfs: task 137 can't get a request slot
nfs: task 138 can't get a request slot
nfs: task 139 can't get a request slot
nfs: task 140 can't get a request slot
nfs: task 141 can't get a request slot
nfs: task 142 can't get a request slot
nfs: task 143 can't get a request slot
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
nfs: server fileserver OK
