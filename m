Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317601AbSGFDR0>; Fri, 5 Jul 2002 23:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSGFDRZ>; Fri, 5 Jul 2002 23:17:25 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19973 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317601AbSGFDRZ>; Fri, 5 Jul 2002 23:17:25 -0400
Date: Sat, 6 Jul 2002 00:19:28 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFT] minimal rmap for 2.5
Message-ID: <Pine.LNX.4.44L.0207060015170.8346-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

below is a minimal rmap patch for 2.5.25, unfortunately
untested because the main hard disk on my test box died
of old age and I'm waiting for the ISO image to download
so I can install Linux on the other spare disk...

If you have some time left this weekend and feel brave,
please test the patch which can be found at:

	http://surriel.com/patches/2.5/2.5.25-rmap-untested

This patch is based on Craig Kulesa's minimal rmap patch
for 2.5.24, with a few changes:
- removed a few unrelated changes
- updated armv/rmap.h for new pagetable layout of linux/arm
- dropped per-zone pte_chain freelists, we want to make per-cpu
  ones for SMP scalability
- ported to 2.5.25 (PF_NOWARN instead of PF_RADIX_TREE)
- drop spelling and whitespace fixes (should be merged separately)

It should be mostly ready for being integrated into the 2.5 tree,
with the note that pte-highmem support still needs to be implemented
(some IBMers have been volunteered for this task, this functionality
can easily be added afterwards).

Right now this patch needs testing and careful scrutiny. If you can
find anything wrong with it, please let me know.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

