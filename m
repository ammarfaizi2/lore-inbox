Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129844AbQLDRFH>; Mon, 4 Dec 2000 12:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130119AbQLDRE6>; Mon, 4 Dec 2000 12:04:58 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:51465 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129844AbQLDREk>; Mon, 4 Dec 2000 12:04:40 -0500
Message-Id: <200012041633.eB4GXOt26866@pincoya.inf.utfsm.cl>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.4.0.12.4: drivers/net/dummy.c fails compile
X-Mailer: MH [Version 6.8.4]
Date: Mon, 04 Dec 2000 13:33:24 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SPARC64, Red Hat 6.2 + local updates


dummy.c: In function `dummy_init_module':
dummy.c:103: invalid type argument of `->'

A patch follows:

--- linux-2.4.0-test/drivers/net/dummy.c~	Mon Dec  4 09:03:05 2000
+++ linux-2.4.0-test/drivers/net/dummy.c	Mon Dec  4 13:27:23 2000
@@ -100,7 +100,7 @@
 	int err;
 
 	dev_dummy.init = dummy_init;
-	SET_MODULE_OWNER(&dev_dummy);
+	SET_MODULE_OWNER((&dev_dummy));
 
 	/* Find a name for this unit */
 	err=dev_alloc_name(&dev_dummy,"dummy%d");
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
