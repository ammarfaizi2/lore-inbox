Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131764AbQLHUrt>; Fri, 8 Dec 2000 15:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132104AbQLHUrj>; Fri, 8 Dec 2000 15:47:39 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:49517
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131764AbQLHUrX>; Fri, 8 Dec 2000 15:47:23 -0500
Date: Fri, 8 Dec 2000 21:16:51 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warnings from drivers/net/eepro.c (240-test12-pre7)
Message-ID: <20001208211651.C599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I sent the following to aris@conectiva.com.br, but forgot to cc linux-kernel).

Hi.

The following patch removes some 'defined but not used' warnings when
compiling drivers/net/eepro.c (240t12p7) without modular support.


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

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

I've always found profanity to be refuge of the inarticulate motherfucker.
  --Anonymous

----- End forwarded message -----

-- 
        Rasmus(rasmus@jaquet.dk)

Without censorship, things can get terribly confused in the
public mind. -General William Westmoreland, during the war in Viet Nam
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
