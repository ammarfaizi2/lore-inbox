Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbQLDR2z>; Mon, 4 Dec 2000 12:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbQLDR2q>; Mon, 4 Dec 2000 12:28:46 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:52745 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129819AbQLDR2d>; Mon, 4 Dec 2000 12:28:33 -0500
Message-Id: <200012041657.eB4Gvit27949@pincoya.inf.utfsm.cl>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.4.0.12.4: dummy.o problem (again)
X-Mailer: MH [Version 6.8.4]
Date: Mon, 04 Dec 2000 13:57:44 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A better (right, IMVHO) patch is:

--- linux-2.4.0-test/include/linux/module.h~	Mon Dec  4 09:06:47 2000
+++ linux-2.4.0-test/include/linux/module.h	Mon Dec  4 13:55:18 2000
@@ -345,7 +345,7 @@
 #endif /* MODULE */
 
 #ifdef CONFIG_MODULES
-#define SET_MODULE_OWNER(some_struct) do { some_struct->owner = THIS_MODULE; } while (0)
+#define SET_MODULE_OWNER(some_struct) do { (some_struct)->owner = THIS_MODULE; } while (0)
 #else
 #define SET_MODULE_OWNER(some_struct) do { } while (0)
 #endif
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
