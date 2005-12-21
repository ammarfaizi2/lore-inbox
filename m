Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVLUJkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVLUJkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLUJkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:40:19 -0500
Received: from odin2.bull.net ([192.90.70.84]:5526 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932339AbVLUJkR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:40:17 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc5-rt4 and CONFIG_SLAB=y : structure has no member named `nodeid'
Date: Wed, 21 Dec 2005 10:45:58 +0100
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Message-Id: <200512211045.58763.Serge.Noiraud@bull.net>
X-MIMETrack: Itemize by SMTP Server on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 21/12/2005 10:40:55,
	Serialize by Router on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 21/12/2005 10:40:57,
	Serialize complete at 21/12/2005 10:40:57
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	testing on i386, I get the following error :
...
  CC      mm/slab.o
mm/slab.c: In function `cache_alloc_refill':
mm/slab.c:2093: error: structure has no member named `nodeid'
mm/slab.c: In function `free_block':
mm/slab.c:2239: error: structure has no member named `nodeid'
mm/slab.c:2239: error: `node' undeclared (first use in this function)
mm/slab.c:2239: error: (Each undeclared identifier is reported only once
mm/slab.c:2239: error: for each function it appears in.)
make[4]: *** [mm/slab.o] Erreur 1
...

You removed nodeid in the slab struct, but many functions use it.

-- 
Serge Noiraud
Bull Téléservice
Bull, Architect of an Open World TM
Tél : 08 02 08 20 00 
http://www.bull.com/ 
