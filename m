Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVCLXY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVCLXY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVCLXXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:23:20 -0500
Received: from aun.it.uu.se ([130.238.12.36]:1226 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261257AbVCLXVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:21:30 -0500
Date: Sun, 13 Mar 2005 00:21:20 +0100 (MET)
Message-Id: <200503122321.j2CNLKel028959@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 5/9: cpu_control_header, common
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Move tsc_on/nractrs/nrictrs control fields to new struct cpu_control_header.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 drivers/perfctr/virtual.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -rupN linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/virtual.c linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/virtual.c
--- linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/virtual.c	2005-03-12 19:26:25.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/virtual.c	2005-03-12 19:58:15.000000000 +0100
@@ -594,7 +594,8 @@ static int vperfctr_enable_control(struc
 	unsigned int next_cstatus;
 	unsigned int nrctrs, i;
 
-	if (perfctr->cpu_state.control.nractrs || perfctr->cpu_state.control.nrictrs) {
+	if (perfctr->cpu_state.control.header.nractrs ||
+	    perfctr->cpu_state.control.header.nrictrs) {
 		cpumask_t old_mask, new_mask;
 
 		old_mask = tsk->cpus_allowed;
