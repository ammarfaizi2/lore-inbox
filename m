Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSAEFR2>; Sat, 5 Jan 2002 00:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287518AbSAEFRR>; Sat, 5 Jan 2002 00:17:17 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:50377 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287516AbSAEFRN>; Sat, 5 Jan 2002 00:17:13 -0500
Date: Fri, 4 Jan 2002 21:16:58 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, hennus@cybercom.nl, torvalds@transmeta.com
Subject: Patch: linux-2.5.2-pre8/include/linux/tpqic02.h kdev_t fix
Message-ID: <20020104211658.A21837@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I forgot to include this header file in my kdev_t
compilation fixes for drivers/char.  This change is needed so
that drivers/char/tpqic02.c will compile correctly.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tpqic02.diff"

--- linux-2.5.2-pre8/include/linux/tpqic02.h	Sun Dec 16 15:44:43 2001
+++ linux/include/linux/tpqic02.h	Fri Jan  4 21:12:42 2002
@@ -587,10 +587,10 @@
  *  |___________________ Reserved for diagnostics during debugging.
  */
 
-#define	TP_REWCLOSE(d)	((MINOR(d)&0x01) == 1)	   		/* rewind bit */
+#define	TP_REWCLOSE(d)	((minor(d)&0x01) == 1)	   		/* rewind bit */
 			   /* rewind is only done if data has been transferred */
-#define	TP_DENS(dev)	((MINOR(dev) >> 1) & 0x07) 	      /* tape density */
-#define TP_UNIT(dev)	((MINOR(dev) >> 4) & 0x07)	       /* unit number */
+#define	TP_DENS(dev)	((minor(dev) >> 1) & 0x07) 	      /* tape density */
+#define TP_UNIT(dev)	((minor(dev) >> 4) & 0x07)	       /* unit number */
 
 /* print excessive diagnostics */
 #define TP_DIAGS(dev)	(QIC02_TAPE_DEBUG & TPQD_DIAGS)

--G4iJoqBmSsgzjUCe--
