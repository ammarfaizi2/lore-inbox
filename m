Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbRE3LKT>; Wed, 30 May 2001 07:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262735AbRE3LKJ>; Wed, 30 May 2001 07:10:09 -0400
Received: from ns.caldera.de ([212.34.180.1]:59367 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S262730AbRE3LJw>;
	Wed, 30 May 2001 07:09:52 -0400
Date: Wed, 30 May 2001 13:09:05 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: 3c509 PNP80f7 id
Message-ID: <20010530130905.A29368@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds the PNP80f7 compat Id to 3c509.c, making it now autodetect my 
'3C509B EtherLink III'.

BTW, there is a problem there:

It has a card id of TCM5094 and a function id of PNP80f7, the cardid is
already there, but only probed as function id...

Anyway, I will let the dust settle on the ISAPNP module issue first before
fixing it ;)

Ciao, Marcus

Index: drivers/net/3c509.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/net/3c509.c,v
retrieving revision 1.17
diff -u -r1.17 3c509.c
--- drivers/net/3c509.c	2001/05/03 13:16:01	1.17
+++ drivers/net/3c509.c	2001/05/30 11:03:21
@@ -192,6 +191,9 @@
 		ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5098),
 		(long) "3Com Etherlink III (TPC)" },
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
+		ISAPNP_VENDOR('P', 'N', 'P'), ISAPNP_FUNCTION(0x80f7),
+		(long) "3Com Etherlink III compatible" },
+	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('P', 'N', 'P'), ISAPNP_FUNCTION(0x80f8),
 		(long) "3Com Etherlink III compatible" },
 	{ }	/* terminate list */
