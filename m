Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264674AbTFLBwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbTFLBt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:49:26 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:30215 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264691AbTFLBsu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:48:50 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10553833522557@movementarian.org>
Subject: [PATCH 3/4] OProfile: remove useless code
In-Reply-To: <10553833502745@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 12 Jun 2003 03:02:32 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19QHQ9-00022J-Ti*9CNFaJXB5C.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove some useless code, from Philippe Elie.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-fixes/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-05-26 05:42:35.000000000 +0100
+++ linux-fixes/drivers/oprofile/buffer_sync.c	2003-06-12 02:05:19.000000000 +0100
@@ -236,8 +236,6 @@
 	struct vm_area_struct * vma;
 
 	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
-		if (!vma)
-			goto out;
  
 		if (!vma->vm_file)
 			continue;
@@ -250,7 +248,7 @@
 		*offset = (vma->vm_pgoff << PAGE_SHIFT) + addr - vma->vm_start; 
 		break;
 	}
-out:
+
 	return cookie;
 }
 

