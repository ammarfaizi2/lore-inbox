Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbQLSTv3>; Tue, 19 Dec 2000 14:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbQLSTvT>; Tue, 19 Dec 2000 14:51:19 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:37372 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S129811AbQLSTvM>;
	Tue, 19 Dec 2000 14:51:12 -0500
Date: Tue, 19 Dec 2000 17:23:32 -0200 (BRDT)
From: aris <aris@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warnings from drivers/net/eepro.c (240-test12-pre7)
 (fwd)
Message-ID: <Pine.LNX.4.21.0012191721270.21257-100000@teste10.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
	as my patches for eepro are getting late, here is a patch from
Rasmus that i would apply with mine, please apply

-- 
							Aris
---------------------------------------------------------------------------
Aristeu Sergio Rozanski Filho                         aris@conectiva.com.br
---------------------------------------------------------------------------

------------------------------------------------------------------------------

--- linux-240-t12-pre7-clean/drivers/net/eepro.c	Fri Dec  8 00:44:58 2000
+++ linux/drivers/net/eepro.c	Fri Dec  8 21:02:50 2000
@@ -1727,6 +1727,8 @@
 		eepro_complete_selreset(ioaddr);
 }
 
+#ifdef MODULE
+
 #define MAX_EEPRO 8
 static struct net_device dev_eepro[MAX_EEPRO];
 
@@ -1737,7 +1739,7 @@
 };
 static int autodetect;
 
-static int n_eepro = 0;
+static int n_eepro;
 /* For linux 2.1.xx */
 
 MODULE_AUTHOR("Pascal Dupuis <dupuis@lei.ucl.ac.be> for the 2.1 stuff (locking,...)");
@@ -1746,8 +1748,6 @@
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_EEPRO) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_EEPRO) "i");
 MODULE_PARM(autodetect, "1-" __MODULE_STRING(1) "i");
-
-#ifdef MODULE
 
 int 
 init_module(void)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
