Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbTBKLe2>; Tue, 11 Feb 2003 06:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267635AbTBKLe2>; Tue, 11 Feb 2003 06:34:28 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:54028 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267633AbTBKLeK>; Tue, 11 Feb 2003 06:34:10 -0500
Date: Tue, 11 Feb 2003 11:43:56 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH 3/4] oprofile update: fix oprofilefs integer files base
Message-ID: <20030211114356.GC57908@compsoc.man.ac.uk>
References: <20030211113227.GH53481@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211113227.GH53481@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18iYpR-000CbH-00*PtoVVobSU5g*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch allows the oprofilefs files to take entry in any base
instead of just base 10


diff -Naur -X dontdiff linux/drivers/oprofile/oprofilefs.c linux2/drivers/oprofile/oprofilefs.c
--- linux/drivers/oprofile/oprofilefs.c	2003-02-10 19:40:25.000000000 +0000
+++ linux2/drivers/oprofile/oprofilefs.c	2003-02-09 23:46:03.000000000 +0000
@@ -114,7 +114,7 @@
 		return -EFAULT;
 
 	spin_lock(&oprofilefs_lock);
-	*val = simple_strtoul(tmpbuf, NULL, 10);
+	*val = simple_strtoul(tmpbuf, NULL, 0);
 	spin_unlock(&oprofilefs_lock);
 	return 0;
 }
