Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131509AbRCUPwc>; Wed, 21 Mar 2001 10:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131528AbRCUPwX>; Wed, 21 Mar 2001 10:52:23 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37865 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131509AbRCUPwM>;
	Wed, 21 Mar 2001 10:52:12 -0500
Message-ID: <3AB8CDE0.2B2619AF@mandrakesoft.com>
Date: Wed, 21 Mar 2001 10:50:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, khc@pm.waw.pl,
        Alan Cox <alan@redhat.com>
Subject: [PATCH] Re: [PATCH] 2.4.3-pre6 - hdlc/dscc4 missing bits
In-Reply-To: <20010321163031.A28981@se1.cogenit.fr>
Content-Type: multipart/mixed;
 boundary="------------36C13D6009DA263B5E0A35B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------36C13D6009DA263B5E0A35B0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

You should use this patch instead, from Alan's tree, for updating
include/linux/if_arp.h...
-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
--------------36C13D6009DA263B5E0A35B0
Content-Type: text/plain; charset=us-ascii;
 name="if-arp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="if-arp.patch"

Index: include/linux/if_arp.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/if_arp.h,v
retrieving revision 1.1.1.21
diff -u -r1.1.1.21 if_arp.h
--- include/linux/if_arp.h	2001/03/20 12:54:44	1.1.1.21
+++ include/linux/if_arp.h	2001/03/21 15:49:59
@@ -50,9 +50,11 @@
 #define ARPHRD_X25	271		/* CCITT X.25			*/
 #define ARPHRD_HWX25	272		/* Boards with X.25 in firmware	*/
 #define ARPHRD_PPP	512
-#define ARPHRD_HDLC	513		/* (Cisco) HDLC 		*/
+#define ARPHRD_CISCO	513		/* Cisco HDLC	 		*/
+#define ARPHRD_HDLC	ARPHRD_CISCO
 #define ARPHRD_LAPB	516		/* LAPB				*/
 #define ARPHRD_DDCMP    517		/* Digital's DDCMP protocol     */
+#define ARPHRD_RAWHDLC	518		/* Raw HDLC			*/
 
 #define ARPHRD_TUNNEL	768		/* IPIP tunnel			*/
 #define ARPHRD_TUNNEL6	769		/* IPIP6 tunnel			*/

--------------36C13D6009DA263B5E0A35B0--

