Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbTFLGr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264765AbTFLGqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:46:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:14258 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264763AbTFLGqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:46:14 -0400
Date: Thu, 12 Jun 2003 12:36:15 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patchset] Fix sign handling bugs in 2.5 -- 2/5; epca
Message-ID: <20030612070613.GC1146@llm08.in.ibm.com>
References: <20030612070330.GA1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612070330.GA1146@llm08.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.70/drivers/char/epca.c	Tue May 27 06:30:41 2003
+++ shb-epca-2.5.70/drivers/char/epca.c	Wed Jun 11 16:09:43 2003
@@ -3740,7 +3740,7 @@
 
 			case 5:
 				board.port = (unsigned char *)ints[index];
-				if (board.port <= 0)
+				if (ints[index] <= 0)
 				{
 					printk(KERN_ERR "<Error> - epca_setup: Invalid io port 0x%x\n", (unsigned int)board.port);
 					invalid_lilo_config = 1;
@@ -3752,7 +3752,7 @@
 
 			case 6:
 				board.membase = (unsigned char *)ints[index];
-				if (board.membase <= 0)
+				if (ints[index] <= 0)
 				{
 					printk(KERN_ERR "<Error> - epca_setup: Invalid memory base 0x%x\n",(unsigned int)board.membase);
 					invalid_lilo_config = 1;
