Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282271AbRLHQq0>; Sat, 8 Dec 2001 11:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282260AbRLHQqQ>; Sat, 8 Dec 2001 11:46:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31752 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282271AbRLHQqB>;
	Sat, 8 Dec 2001 11:46:01 -0500
Date: Sat, 8 Dec 2001 17:45:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre7 ide-cd module
Message-ID: <20011208164552.GR11567@suse.de>
In-Reply-To: <3C1235C4.BC20AC8E@wanadoo.fr> <20011208161847.GK11567@suse.de> <3C12421C.47337242@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <3C12421C.47337242@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 08 2001, Pierre Rousselet wrote:
> > Is this a new problem?
> 
> The same is in 2.5.1-pre5 (i reported the 'Can play audio : 0' to l-k).

How about 2.4.16? Try attached patch.

-- 
Jens Axboe


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-cd-cap

--- /opt/kernel/linux-2.5.1-pre7/drivers/ide/ide-cd.c	Fri Dec  7 20:38:44 2001
+++ drivers/ide/ide-cd.c	Sat Dec  8 11:42:47 2001
@@ -2527,8 +2527,10 @@
 	 * page capabilities size, but older drives break.
 	 */
 	if (drive->id) {
-		if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
-		    !strcmp(drive->id->model, "WPI CDS-32X")))
+		if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX")
+		    || !strcmp(drive->id->model, "WPI CDS-32X"))
+		    || !strcmp(drive->id->model, "CRD-8240B"))
+
 			size -= sizeof(cap->pad);
 	}
 

--IrhDeMKUP4DT/M7F--
