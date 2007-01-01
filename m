Return-Path: <linux-kernel-owner+w=401wt.eu-S932793AbXAATxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbXAATxg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbXAATxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:53:05 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52691 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbXAATwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:52:44 -0500
Message-Id: <200701011947.l01JlCcd020771@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/8] UML - make two variables static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2007 14:47:12 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make a couple of variables static.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/port_kern.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/port_kern.c	2007-01-01 11:32:22.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/port_kern.c	2007-01-01 12:03:54.000000000 -0500
@@ -129,8 +129,8 @@ static int port_accept(struct port_list 
 	return(ret);
 } 
 
-DECLARE_MUTEX(ports_sem);
-struct list_head ports = LIST_HEAD_INIT(ports);
+static DECLARE_MUTEX(ports_sem);
+static struct list_head ports = LIST_HEAD_INIT(ports);
 
 void port_work_proc(struct work_struct *unused)
 {

