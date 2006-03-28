Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWC1WbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWC1WbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWC1WbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:31:05 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:31169 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932463AbWC1WbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:31:04 -0500
Date: Tue, 28 Mar 2006 17:30:48 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Morton Andrew Morton <akpm@osdl.org>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] 64 bit resources more sound changes
Message-ID: <20060328223048.GF20335@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060328222703.GD20335@in.ibm.com> <20060328222827.GE20335@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328222827.GE20335@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes required to fix compilation warnings for sound/* dir for 64bit
  resources. These changes came up due to cross-compilation on powerpc
  with CONFIG_PPC32=y

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 sound/ppc/pmac.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff -puN sound/ppc/pmac.c~64bit-resources-more-sound-changes sound/ppc/pmac.c
--- linux-2.6.16-mm2-64bit-res/sound/ppc/pmac.c~64bit-resources-more-sound-changes	2006-03-28 16:20:03.000000000 -0500
+++ linux-2.6.16-mm2-64bit-res-root/sound/ppc/pmac.c	2006-03-28 16:20:29.000000000 -0500
@@ -1198,9 +1198,10 @@ int __init snd_pmac_new(struct snd_card 
 					       chip->rsrc[i].start + 1,
 					       rnames[i]) == NULL) {
 				printk(KERN_ERR "snd: can't request rsrc "
-				       " %d (%s: 0x%08lx:%08lx)\n",
-				       i, rnames[i], chip->rsrc[i].start,
-				       chip->rsrc[i].end);
+				       " %d (%s: 0x%016llx:%016llx)\n",
+				       i, rnames[i],
+				       (unsigned long long)chip->rsrc[i].start,
+				       (unsigned long long)chip->rsrc[i].end);
 				err = -ENODEV;
 				goto __error;
 			}
@@ -1229,9 +1230,10 @@ int __init snd_pmac_new(struct snd_card 
 					       chip->rsrc[i].start + 1,
 					       rnames[i]) == NULL) {
 				printk(KERN_ERR "snd: can't request rsrc "
-				       " %d (%s: 0x%08lx:%08lx)\n",
-				       i, rnames[i], chip->rsrc[i].start,
-				       chip->rsrc[i].end);
+				       " %d (%s: 0x%016llx:%016llx)\n",
+				       i, rnames[i],
+				       (unsigned long long)chip->rsrc[i].start,
+				       (unsigned long long)chip->rsrc[i].end);
 				err = -ENODEV;
 				goto __error;
 			}
_
