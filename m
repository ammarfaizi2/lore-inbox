Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRDTEA4>; Fri, 20 Apr 2001 00:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135790AbRDTEAp>; Fri, 20 Apr 2001 00:00:45 -0400
Received: from ns.suse.de ([213.95.15.193]:7945 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129359AbRDTEAd>;
	Fri, 20 Apr 2001 00:00:33 -0400
Date: Fri, 20 Apr 2001 05:58:33 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Subject: ISDN compile fix for 2.4.4-pre5
Message-ID: <20010420055833.A9786@pingi.muc.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Organization: SuSE Muenchen GmbH
X-Operating-System: Linux 2.2.18-SMP i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

seems that somehow isdn.h changes get lost during the merge.
Following patch fix this and some other minor things.
 
-- 
Karsten Keil
SuSE Labs
ISDN development
--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="isdn-fix-2.4.4p5.diff"

diff -urN linux-2.4.4p5.org/drivers/isdn/hisax/md5sums.asc linux/drivers/isdn/hisax/md5sums.asc
--- linux-2.4.4p5.org/drivers/isdn/hisax/md5sums.asc	Sun Apr 15 20:36:46 2001
+++ linux/drivers/isdn/hisax/md5sums.asc	Fri Apr 20 04:50:38 2001
@@ -7,27 +7,27 @@
 # cards in the moment.
 # Read ../../../Documentation/isdn/HiSax.cert for more informations.
 # 
-ca7bd9bac39203f3074f3f093948cc3c  isac.c
-a2ad619fd404b3149099a2984de9d23c  isdnl1.c
-d2a78e407f3d94876deac160c6f9aae6  isdnl2.c
-e7932ca7ae39c497c17f13a2e1434fcd  isdnl3.c
-afb5f2f4ac296d6de45c856993b161e1  tei.c
-00023e2a482cb86a26ea870577ade5d6  callc.c
-a1834e9b2ec068440cff2e899eff4710  cert.c
-1551f78b3cd01097ecd586b5c96d0765  l3dss1.c
-89aecf3a80489c723dc885fcaa4aba1b  l3_1tr6.c
-1685c1ddfecf3e1b88ae5f3d7202ce69  elsa.c
-6d7056d1558bf6cc57dd89b7b260dc27  diva.c
-4398918680d45c4618bb48108ea0c282  sedlbauer.c
+9663cc9f4374c361197d394f6d27c459  isac.c
+9666c672c0fa0e65d5cc5b322f10a18c  isdnl1.c
+9250f15b932dfc36855aa120b896ed0b  isdnl2.c
+0cc2ef892bdb4a2be473e00eb1398950  isdnl3.c
+cac9c32fff889c57ff50d59823053019  tei.c
+665044a72334336533ac79da1a831b17  callc.c
+e592db58630c1f1029cc064110108156  cert.c
+fadeb3b85bb23bc1ac48470c0848d6fa  l3dss1.c
+cf7dec9fac6283716904d26b99188476  l3_1tr6.c
+65d9e5471bc129624f858ebcf0743525  elsa.c
+b4cf8a4dceed9ea6dcba65a85b4eecc7  diva.c
+99e67bea8f6945fa0d4e0aded5bf0fa0  sedlbauer.c
 # end of md5sums
 
 -----BEGIN PGP SIGNATURE-----
 Version: 2.6.3i
 Charset: noconv
 
-iQCVAwUBOlxeLTpxHvX/mS9tAQH6RwP8DhyvqAnXFV6WIGi16iQ3vKikkPoqnDQs
-GEn5uCW0dPYKlwthD2Grj/JbMYZhOmCFuDxF7ufJnjTSDe/D8XNe2wngxzAiwcIe
-WjCrT8X95cuP3HZHscbFTEinVV0GAnoI0ZEgs5eBDhVHDqILLYMaTFBQaRH3jgXc
-i5VH88jPfUM=
-=qc+J
+iQCVAwUBOt+j/jpxHvX/mS9tAQGXwAP/U4voKzXAcTfo9CqJhHN92GRxunj6mlvn
+H+1pxSe0GdtC7BlrPhrokB5dNSwewk89Z5t7kTD76kx2FFuTcXBJxbgH7LZVF3ga
+JX92bOWQekHMH7Hk12Qc7zpeTmPzY02pvVc37Eo614BCvJMCk02cpQyo8a5wWRKH
+8vpQkQKiSyY=
+=FFLG
 -----END PGP SIGNATURE-----
diff -urN linux-2.4.4p5.org/include/linux/isdn.h linux/include/linux/isdn.h
--- linux-2.4.4p5.org/include/linux/isdn.h	Fri Apr 20 04:55:51 2001
+++ linux/include/linux/isdn.h	Fri Apr 20 04:50:16 2001
@@ -1,4 +1,4 @@
-/* $Id: isdn.h,v 1.111.6.1 2001/02/07 11:31:31 kai Exp $
+/* $Id: isdn.h,v 1.111.6.5 2001/04/20 02:40:48 keil Exp $
 
  * Main header for the Linux ISDN subsystem (linklevel).
  *
@@ -25,7 +25,9 @@
 #ifndef isdn_h
 #define isdn_h
 
+#ifdef __KERNEL__
 #include <linux/config.h>
+#endif
 #include <linux/ioctl.h>
 
 #define ISDN_TTY_MAJOR    43
@@ -37,8 +39,14 @@
  * the correspondent code in isdn.c
  */
 
+#ifdef USE_MINIMUM_MEM
+/* Save memory */
+#define ISDN_MAX_DRIVERS    2
+#define ISDN_MAX_CHANNELS   8
+#else
 #define ISDN_MAX_DRIVERS    32
 #define ISDN_MAX_CHANNELS   64
+#endif
 #define ISDN_MINOR_B        0
 #define ISDN_MINOR_BMAX     (ISDN_MAX_CHANNELS-1)
 #define ISDN_MINOR_CTRL     64
@@ -98,6 +106,12 @@
 
 #define IIOCDRVCTL  _IO('I',128)
 
+/* cisco hdlck device private ioctls */
+#define SIOCGKEEPPERIOD	(SIOCDEVPRIVATE + 0)
+#define SIOCSKEEPPERIOD	(SIOCDEVPRIVATE + 1)
+#define SIOCGDEBSERINT	(SIOCDEVPRIVATE + 2)
+#define SIOCSDEBSERINT	(SIOCDEVPRIVATE + 3)
+
 /* Packet encapsulations for net-interfaces */
 #define ISDN_NET_ENCAP_ETHER      0
 #define ISDN_NET_ENCAP_RAWIP      1
@@ -258,9 +272,9 @@
                              ((x & ISDN_USAGE_MASK)==ISDN_USAGE_VOICE)     )
 
 /* Timer-delays and scheduling-flags */
-#define ISDN_TIMER_RES         3                         /* Main Timer-Resolution   */
-#define ISDN_TIMER_02SEC       (HZ/(ISDN_TIMER_RES+1)/5) /* Slow-Timer1 .2 sec      */
-#define ISDN_TIMER_1SEC        (HZ/(ISDN_TIMER_RES+1))   /* Slow-Timer2 1 sec       */
+#define ISDN_TIMER_RES         4                         /* Main Timer-Resolution   */
+#define ISDN_TIMER_02SEC       (HZ/ISDN_TIMER_RES/5)     /* Slow-Timer1 .2 sec      */
+#define ISDN_TIMER_1SEC        (HZ/ISDN_TIMER_RES)       /* Slow-Timer2 1 sec       */
 #define ISDN_TIMER_RINGING     5 /* tty RINGs = ISDN_TIMER_1SEC * this factor       */
 #define ISDN_TIMER_KEEPINT    10 /* Cisco-Keepalive = ISDN_TIMER_1SEC * this factor */
 #define ISDN_TIMER_MODEMREAD   1
@@ -269,13 +283,11 @@
 #define ISDN_TIMER_MODEMXMIT   8
 #define ISDN_TIMER_NETDIAL    16 
 #define ISDN_TIMER_NETHANGUP  32
-#define ISDN_TIMER_KEEPALIVE 128 /* Cisco-Keepalive */
 #define ISDN_TIMER_CARRIER   256 /* Wait for Carrier */
 #define ISDN_TIMER_FAST      (ISDN_TIMER_MODEMREAD | ISDN_TIMER_MODEMPLUS | \
                               ISDN_TIMER_MODEMXMIT)
 #define ISDN_TIMER_SLOW      (ISDN_TIMER_MODEMRING | ISDN_TIMER_NETHANGUP | \
-                              ISDN_TIMER_NETDIAL | ISDN_TIMER_KEEPALIVE | \
-                              ISDN_TIMER_CARRIER)
+                              ISDN_TIMER_NETDIAL | ISDN_TIMER_CARRIER)
 
 /* Timeout-Values for isdn_net_dial() */
 #define ISDN_TIMER_DTIMEOUT10 (10*HZ/(ISDN_TIMER_02SEC*(ISDN_TIMER_RES+1)))
@@ -397,9 +409,15 @@
 #ifdef CONFIG_ISDN_X25
   struct concap_device_ops *dops;      /* callbacks used by encapsulator   */
 #endif
-  int  cisco_loop;                     /* Loop counter for Cisco-SLARP     */
+  /* use an own struct for that in later versions */
   ulong cisco_myseq;                   /* Local keepalive seq. for Cisco   */
+  ulong cisco_mineseen;                /* returned keepalive seq. from remote */
   ulong cisco_yourseq;                 /* Remote keepalive seq. for Cisco  */
+  int cisco_keepalive_period;		/* keepalive period */
+  ulong cisco_last_slarp_in;		/* jiffie of last keepalive packet we received */
+  char cisco_line_state;		/* state of line according to keepalive packets */
+  char cisco_debserint;			/* debugging flag of cisco hdlc with slarp */
+  struct timer_list cisco_timer;
   struct tq_struct tqueue;
 } isdn_net_local;
 
diff -urN linux-2.4.4p5.org/include/linux/isdn_ppp.h linux/include/linux/isdn_ppp.h
--- linux-2.4.4p5.org/include/linux/isdn_ppp.h	Sun Apr 15 20:37:14 2001
+++ linux/include/linux/isdn_ppp.h	Fri Apr 20 03:36:50 2001
@@ -3,7 +3,9 @@
 #ifndef _LINUX_ISDN_PPP_H
 #define _LINUX_ISDN_PPP_H
 
+#ifdef __KERNEL__
 #include <linux/config.h>
+#endif
 
 #define CALLTYPE_INCOMING 0x1
 #define CALLTYPE_OUTGOING 0x2
diff -urN linux-2.4.4p5.org/include/linux/isdnif.h linux/include/linux/isdnif.h
--- linux-2.4.4p5.org/include/linux/isdnif.h	Mon Dec 11 22:20:27 2000
+++ linux/include/linux/isdnif.h	Fri Apr 20 03:36:50 2001
@@ -26,7 +26,9 @@
 #ifndef isdnif_h
 #define isdnif_h
 
+#ifdef __KERNEL__
 #include <linux/config.h>
+#endif
 
 /*
  * Values for general protocol-selection

--0F1p//8PRICkK4MW--
