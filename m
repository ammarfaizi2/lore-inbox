Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTBXTYB>; Mon, 24 Feb 2003 14:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267289AbTBXTYB>; Mon, 24 Feb 2003 14:24:01 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:6417 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S267277AbTBXTYA>;
	Mon, 24 Feb 2003 14:24:00 -0500
Date: Mon, 24 Feb 2003 19:34:13 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] typo in slab.c debug ?
Message-ID: <20030224193413.GA9397@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18nOMf-0002aK-00*rucNGigc2hU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looked like this condition was previously always false ...

Not tested or anything ... 2.5.62

john

--- linux-linus/mm/slab.c	2003-02-18 00:38:40.000000000 +0000
+++ linux/mm/slab.c	2003-02-24 19:36:47.000000000 +0000
@@ -1643,7 +1643,7 @@
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {
 		unsigned long	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 
-		if (!flags & __GFP_WAIT)
+		if (!(flags & __GFP_WAIT))
 			ctor_flags |= SLAB_CTOR_ATOMIC;
 
 		cachep->ctor(objp, cachep, ctor_flags);
