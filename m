Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSDETuy>; Fri, 5 Apr 2002 14:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSDETuo>; Fri, 5 Apr 2002 14:50:44 -0500
Received: from zero.tech9.net ([209.61.188.187]:27152 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313305AbSDETu3>;
	Fri, 5 Apr 2002 14:50:29 -0500
Subject: [PATCH] 2.4-ac: config error
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-9pu81t+2g1b3t9Kz9gbL"
X-Mailer: Ximian Evolution 1.0.3 
Date: 05 Apr 2002 14:50:21 -0500
Message-Id: <1018036222.29103.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9pu81t+2g1b3t9Kz9gbL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Apologies if this has been sent but drivers/pcmcia/Config.in has a lil
buglet that prevents make xconfig and related from running.

Attached patch, against 2.4.19-pre5-ac2, fixes.

	Robert Love

--=-9pu81t+2g1b3t9Kz9gbL
Content-Disposition: attachment; filename=config-error-rml-2.4.19-pre5-ac2-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=config-error-rml-2.4.19-pre5-ac2-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre5-ac2/drivers/pcmcia/Config.in linux/drivers/pcmc=
ia/Config.in
--- linux-2.4.19-pre5-ac2/drivers/pcmcia/Config.in	Fri Apr  5 14:32:26 2002
+++ linux/drivers/pcmcia/Config.in	Fri Apr  5 14:46:09 2002
@@ -24,7 +24,7 @@
    dep_bool '  i82092 compatible bridge support' CONFIG_I82092 $CONFIG_PCI
    bool '  i82365 compatible bridge support' CONFIG_I82365
    if [ "$CONFIG_ARCH_SA1100" =3D "y" ]; then
-	dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100
+	dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_PCI
    fi
 fi
 endmenu

--=-9pu81t+2g1b3t9Kz9gbL--

