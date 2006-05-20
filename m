Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWETUvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWETUvY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 16:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWETUvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 16:51:23 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:45711 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751484AbWETUvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 16:51:23 -0400
Date: Sat, 20 May 2006 16:50:59 -0400 (EDT)
From: Ameer Armaly <ameer@bellsouth.net>
X-X-Sender: ameer@sg1
To: linux-kernel@vger.kernel.org
Subject: [patch] intialize cpu_freq in arch/i386/kernel/cpu/transmeta.c
Message-ID: <Pine.LNX.4.61.0605201648430.18009@sg1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing cpu_freq to 0 in arch/i386/kernel/cpu/transmeta.c gets rid of 
an unnecessary warning.
Initialized cpu_freq in arch/i386/kernel/cpu/transmeta.c to suppress warning.

---
commit 53121ea5e13e075e5239734bb26c3cae7ee84ee0
tree 0eca3170380c610969118c6fa7700558b7232e5d
parent 6566a3f8f3281497a81815dfe2b64eb54dafe05d
author Ameer Armaly <ameer_armaly@hotmail.com> Sat, 20 May 2006 16:43:05 -0400
committer Ameer Armaly <ameer@sg1.(none)> Sat, 20 May 2006 16:43:05 -0400

  arch/i386/kernel/cpu/transmeta.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/cpu/transmeta.c b/arch/i386/kernel/cpu/transmeta.c
index 7214c9b..0737890 100644
--- a/arch/i386/kernel/cpu/transmeta.c
+++ b/arch/i386/kernel/cpu/transmeta.c
@@ -9,7 +9,7 @@ static void __init init_transmeta(struct
  {
  	unsigned int cap_mask, uk, max, dummy;
  	unsigned int cms_rev1, cms_rev2;
-	unsigned int cpu_rev, cpu_freq, cpu_flags, new_cpu_rev;
+	unsigned int cpu_rev, cpu_freq = 0, cpu_flags, new_cpu_rev;
  	char cpu_info[65];

  	get_model_name(c);	/* Same as AMD/Cyrix */
