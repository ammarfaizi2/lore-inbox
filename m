Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUFDVi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUFDVi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 17:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUFDVi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 17:38:58 -0400
Received: from adsl-186.flex.com ([206.126.1.185]:44684 "EHLO mail.imodulo.com")
	by vger.kernel.org with ESMTP id S266014AbUFDVi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 17:38:56 -0400
Date: Fri, 4 Jun 2004 11:38:55 -1000
From: Glen Nakamura <glen@imodulo.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix comment typo in nForce2 C1halt fixup for 2.4.27-pre5
Message-ID: <20040604213855.GA2864@modulo.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aloha,

The comment for the nForce2 C1halt fixup doesn't match the code
and information posted by Allen Martin:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108362246902784&w=2

- Glen Nakamura

Here is the patch:

diff -Nru3p linux-2.4.27-pre5.orig/arch/i386/kernel/pci-pc.c linux-2.4.27-pre5/arch/i386/kernel/pci-pc.c
--- linux-2.4.27-pre5.orig/arch/i386/kernel/pci-pc.c	2004-06-02 15:33:55.000000000 -1000
+++ linux-2.4.27-pre5/arch/i386/kernel/pci-pc.c	2004-06-02 15:33:55.000000000 -1000
@@ -1349,8 +1349,8 @@ static void __devinit pci_fixup_nforce2(
 
 	/*
 	* Chip 	Old value   	New value
-	* C17  	0x1F01FF01  	0x1F0FFF01
-	* C18D 	0x9F01FF01  	0x9F0FFF01
+	* C17  	0x1F0FFF01  	0x1F01FF01
+	* C18D 	0x9F0FFF01  	0x9F01FF01
 	*/
 	fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;
 
