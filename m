Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVC3TAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVC3TAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVC3Sz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:55:26 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:18062 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262397AbVC3Sv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:51:28 -0500
Subject: [patch 7/8] uml: correct error message [for 2.6.12]
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       Anthony_Brock@ous.edu
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:34:03 +0200
Message-Id: <20050330173403.477AEEFF28@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, "Anthony Brock" <Anthony_Brock@ous.edu>

Replace the message with a more meaningful one. Noted by Anthony Brock.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/um_arch.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/um_arch.c~uml-correct-message arch/um/kernel/um_arch.c
--- linux-2.6.11/arch/um/kernel/um_arch.c~uml-correct-message	2005-03-24 03:04:59.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/um_arch.c	2005-03-24 03:05:36.000000000 +0100
@@ -47,7 +47,7 @@ char command_line[COMMAND_LINE_SIZE] = {
 void add_arg(char *arg)
 {
 	if (strlen(command_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
-		printf("add_arg: Too much command line!\n");
+		printf("add_arg: Too many command line arguments!\n");
 		exit(1);
 	}
 	if(strlen(command_line) > 0)
_
