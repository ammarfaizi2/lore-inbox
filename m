Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131943AbRACCRF>; Tue, 2 Jan 2001 21:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130804AbRACCQ4>; Tue, 2 Jan 2001 21:16:56 -0500
Received: from [139.102.15.42] ([139.102.15.42]:18330 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S131943AbRACCQg>; Tue, 2 Jan 2001 21:16:36 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: linux-kernel@vger.kernel.org
Date: Tue, 2 Jan 2001 20:45:18 -0500
MIME-Version: 1.0
Content-type: text/enriched; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [PATCH] Remove more compile warnings in 2.4.0-prerelease
Reply-to: richbaum@acm.org
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <3A523DDE.23101.AC9EBA@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<color><param>0100,0100,0100</param>Here is a patch that removes more compile warnings from 2.4.0-
prerelease. I left out files that have been fixed by Alan or myself in 
the ac kernels. I'll add more options to my config tomorrow to try to 
find more of these warnings.


</color>Rich


<color><param>0100,0100,0100</param>diff -urN linux/drivers/i2c/i2c-pcf8584.h rb/drivers/i2c/i2c-pcf8584.h

--- linux/drivers/i2c/i2c-pcf8584.h	Fri Jan 28 22:36:23 2000

+++ rb/drivers/i2c/i2c-pcf8584.h	Tue Jan  2 16:47:36 2001

@@ -75,4 +75,4 @@

 #define I2C_PCF_INTREG	I2C_PCF_ES2

 #define I2C_PCF_CLKREG	I2C_PCF_ES1

 


-#endif I2C_PCF8584_H

+#endif /* I2C_PCF8584_H */

diff -urN linux/drivers/i2o/i2o_lan.c rb/drivers/i2o/i2o_lan.c

--- linux/drivers/i2o/i2o_lan.c	Mon Dec 11 15:39:44 2000

+++ rb/drivers/i2o/i2o_lan.c	Tue Jan  2 16:48:01 2001

@@ -938,7 +938,7 @@

 	spin_unlock_irq(&priv->tx_lock);

 	return 0;

 }

-#endif CONFIG_NET_FC

+#endif /* CONFIG_NET_FC */

 


 /*

  * i2o_lan_packet_send(): Send a packet as is, including the MAC header.

diff -urN linux/drivers/isdn/hisax/hisax.h rb/drivers/isdn/hisax/hisax.h

--- linux/drivers/isdn/hisax/hisax.h	Tue Jan  2 10:34:53 2001

+++ rb/drivers/isdn/hisax/hisax.h	Tue Jan  2 16:51:34 2001

@@ -126,13 +126,13 @@

   #define l3dss1_process

   #include "l3dss1.h" 

   #undef  l3dss1_process

-#endif CONFIG_HISAX_EURO

+#endif /* CONFIG_HISAX_EURO */

 


 #ifdef CONFIG_HISAX_NI1

   #define l3ni1_process

   #include "l3ni1.h" 

   #undef  l3ni1_process

-#endif CONFIG_HISAX_NI1

+#endif /* CONFIG_HISAX_NI1 */

 


 #define MAX_DFRAME_LEN	260

 #define MAX_DFRAME_LEN_L1	300

@@ -318,10 +318,10 @@

 	 { u_char uuuu; /* only as dummy */

 #ifdef CONFIG_HISAX_EURO

            dss1_stk_priv dss1; /* private dss1 data */

-#endif CONFIG_HISAX_EURO              

+#endif /* CONFIG_HISAX_EURO */             

 #ifdef CONFIG_HISAX_NI1

            ni1_stk_priv ni1; /* private ni1 data */

-#endif CONFIG_HISAX_NI1              

+#endif /* CONFIG_HISAX_NI1 */            

 	 } prot;

 };

 


@@ -342,10 +342,10 @@

 	 { u_char uuuu; /* only when euro not defined, avoiding empty union */

 #ifdef CONFIG_HISAX_EURO 

            dss1_proc_priv dss1; /* private dss1 data */

-#endif CONFIG_HISAX_EURO            

+#endif /* CONFIG_HISAX_EURO */           

 #ifdef CONFIG_HISAX_NI1

            ni1_proc_priv ni1; /* private ni1 data */

-#endif CONFIG_HISAX_NI1              

+#endif /* CONFIG_HISAX_NI1 */             

 	 } prot;

 };

 


diff -urN linux/drivers/isdn/isdn_common.c rb/drivers/isdn/isdn_common.c

--- linux/drivers/isdn/isdn_common.c	Tue Jan  2 10:34:53 2001

+++ rb/drivers/isdn/isdn_common.c	Tue Jan  2 16:50:02 2001

@@ -41,7 +41,7 @@

 #endif

 #ifdef CONFIG_ISDN_DIVERSION

 #include <<linux/isdn_divertif.h>

-#endif CONFIG_ISDN_DIVERSION

+#endif /* CONFIG_ISDN_DIVERSION */

 #include "isdn_v110.h"

 #include "isdn_cards.h"

 #include <<linux/devfs_fs_kernel.h>

@@ -69,7 +69,7 @@

 


 #ifdef CONFIG_ISDN_DIVERSION

 isdn_divert_if *divert_if; /* interface to diversion module */

-#endif CONFIG_ISDN_DIVERSION

+#endif /* CONFIG_ISDN_DIVERSION */

 


 

 static int isdn_writebuf_stub(int, int, const u_char *, int, int);

@@ -519,7 +519,7 @@

                                          if (divert_if)

                  	                  if ((retval = divert_if->stat_callback(c))) 

 					    return(retval); /* processed */

-#endif CONFIG_ISDN_DIVERSION                        

+#endif /* CONFIG_ISDN_DIVERSION */                       

 					if ((!retval) && (dev->drv[di]->flags & DRV_FLAG_REJBUS)) {

 						/* No tty responding */

 						cmd.driver = di;

@@ -592,7 +592,7 @@

 #ifdef CONFIG_ISDN_DIVERSION

                         if (divert_if)

                          divert_if->stat_callback(c); 

-#endif CONFIG_ISDN_DIVERSION

+#endif /* CONFIG_ISDN_DIVERSION */

 			break;

 		case ISDN_STAT_DISPLAY:

 #ifdef ISDN_DEBUG_STATCALLB

@@ -602,7 +602,7 @@

 #ifdef CONFIG_ISDN_DIVERSION

                         if (divert_if)

                          divert_if->stat_callback(c); 

-#endif CONFIG_ISDN_DIVERSION

+#endif /* CONFIG_ISDN_DIVERSION */

 			break;

 		case ISDN_STAT_DCONN:

 			if (i << 0)

@@ -644,7 +644,7 @@

 #ifdef CONFIG_ISDN_DIVERSION

                         if (divert_if)

                          divert_if->stat_callback(c); 

-#endif CONFIG_ISDN_DIVERSION

+#endif /* CONFIG_ISDN_DIVERSION */

 			break;

 			break;

 		case ISDN_STAT_BCONN:

@@ -773,7 +773,7 @@

 	        case ISDN_STAT_REDIR:

                         if (divert_if)

                           return(divert_if->stat_callback(c));

-#endif CONFIG_ISDN_DIVERSION

+#endif /* CONFIG_ISDN_DIVERSION */

 		default:

 			return -1;

 	}

@@ -2167,7 +2167,7 @@

 


 EXPORT_SYMBOL(DIVERT_REG_NAME);

 


-#endif CONFIG_ISDN_DIVERSION

+#endif /* CONFIG_ISDN_DIVERSION */

 


 

 EXPORT_SYMBOL(register_isdn);

diff -urN linux/include/linux/802_11.h rb/include/linux/802_11.h

--- linux/include/linux/802_11.h	Mon Dec 11 16:00:51 2000

+++ rb/include/linux/802_11.h	Tue Jan  2 16:52:22 2001

@@ -188,4 +188,5 @@

 }

 


 

-#endif

\ No newline at end of file

+#endif

+

diff -urN linux/include/linux/nubus.h rb/include/linux/nubus.h

--- linux/include/linux/nubus.h	Sat Sep  4 15:10:30 1999

+++ rb/include/linux/nubus.h	Tue Jan  2 16:52:59 2001

@@ -319,4 +319,4 @@

 	return (void *)(0xF0000000|(slot<<<<24));

 }

 


-#endif LINUX_NUBUS_H

+#endif /* LINUX_NUBUS_H */



<nofill>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
