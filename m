Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130698AbRBPVpg>; Fri, 16 Feb 2001 16:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRBPVp1>; Fri, 16 Feb 2001 16:45:27 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:34110 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130698AbRBPVpU>; Fri, 16 Feb 2001 16:45:20 -0500
Date: Fri, 16 Feb 2001 22:56:40 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: linux-kernel@vger.kernel.org
Subject: [patchlet] One liner "fix" to mm/vmalloc.c
Message-ID: <Pine.LNX.4.21.0102162255330.884-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right above the "if (!pmd)" ret is also set to -ENOMEM...

--- mm/vmalloc.c.old    Fri Feb 16 22:47:59 2001
+++ mm/vmalloc.c        Fri Feb 16 22:48:16 2001
@@ -151,7 +151,6 @@
                if (!pmd)
                        break;

-               ret = -ENOMEM;
                if (alloc_area_pmd(pmd, address, end - address, gfp_mask,
prot))
                        break;



-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

