Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbVLRQwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbVLRQwI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 11:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbVLRQwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 11:52:07 -0500
Received: from host229-46.pool8259.interbusiness.it ([82.59.46.229]:57304 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965220AbVLRQwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 11:52:06 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/4] uml - fix some funkiness in Kconfig
Date: Sun, 18 Dec 2005 17:50:37 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051218165037.441.85975.stgit@zion.home.lan>
In-Reply-To: <20051218164916.441.69564.stgit@zion.home.lan>
References: <20051218164916.441.69564.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So you may have seen the miniconfig stuff wander by, which means that my build
script exits if there's a .config error, and we have this:

fs/Kconfig:1749:warning: 'select' used by config symbol 'CIFS_UPCALL' refer to
undefined symbol 'CONNECTOR'

This makes it shut up.

Signed-off-by: Rob Landley <rob@landley.net>

Verified it makes sense.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 563301f..1eb21de 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -289,6 +289,8 @@ source "arch/um/Kconfig.net"
 
 source "drivers/net/Kconfig"
 
+source "drivers/connector/Kconfig"
+
 source "fs/Kconfig"
 
 source "security/Kconfig"

