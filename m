Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTEVPjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTEVPjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:39:22 -0400
Received: from holomorphy.com ([66.224.33.161]:27532 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261970AbTEVPjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:39:21 -0400
Date: Thu, 22 May 2003 08:52:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 8250 revision width fix
Message-ID: <20030522155211.GR2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -prauN mm8-2.5.69-1/drivers/serial/8250.c mm8-2.5.69-2/drivers/serial/8250.c
--- mm8-2.5.69-1/drivers/serial/8250.c	2003-05-22 04:54:56.000000000 -0700
+++ mm8-2.5.69-2/drivers/serial/8250.c	2003-05-22 07:48:48.000000000 -0700
@@ -124,7 +124,7 @@ struct uart_8250_port {
 	struct list_head	list;		/* ports on this IRQ */
 	unsigned char		acr;
 	unsigned char		ier;
-	unsigned char		rev;
+	unsigned short		rev;
 	unsigned char		lcr;
 	unsigned char		mcr_mask;	/* mask of user bits */
 	unsigned char		mcr_force;	/* mask of forced bits */
