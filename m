Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSKMVD5>; Wed, 13 Nov 2002 16:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSKMVD5>; Wed, 13 Nov 2002 16:03:57 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9220 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262808AbSKMVD4>;
	Wed, 13 Nov 2002 16:03:56 -0500
Date: Wed, 13 Nov 2002 22:10:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.47-ac2 initializes mcheck twice...
Message-ID: <20021113211008.GA7542@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...and it will not compile with mcheck disabled. This is (maybe
right?) fix.
								Pavel

--- clean-ac/arch/i386/kernel/cpu/common.c	2002-11-13 21:38:10.000000000 +0100
+++ linux-ac/arch/i386/kernel/cpu/common.c	2002-11-13 21:55:56.000000000 +0100
@@ -315,9 +315,6 @@
 		clear_bit(X86_FEATURE_XMM, c->x86_capability);
 	}
 
-	/* Init Machine Check Exception if available. */
-	mcheck_init(c);
-
 	/* If the model name is still unset, do table lookup. */
 	if ( !c->x86_model_id[0] ) {
 		char *p;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
