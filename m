Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263977AbTJFE6r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 00:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbTJFE6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 00:58:47 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:33714 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S263977AbTJFE6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 00:58:42 -0400
Subject: [PATCH] Re: Linux 2.4.23-pre6 fix make xconfig
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
To: acpi-devel <acpi-devel@lists.sourceforge.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-QtCayqDf4TmhutyAshrl"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 06 Oct 2003 05:58:18 +0100
Message-Id: <1065416298.1634.12.camel@darkstar.portugal>
Mime-Version: 1.0
X-OriginalArrivalTime: 06 Oct 2003 04:53:35.0101 (UTC) FILETIME=[CC6CDAD0:01C38BC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QtCayqDf4TmhutyAshrl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi
Finally, I found what is fucking (at least with redhat 7.3 :) the make
xconfig in Linux 2.4.23-pre6.=20


I just don't know what patch do you prefer ?
Please apply one of then=20
I prefer the first.=20

thanks
--=20
S=E9rgioMB
email: sergiomb@netcabo.pt

Who gives me one shell, give me everything.

--=-QtCayqDf4TmhutyAshrl
Content-Disposition: attachment; filename=config2.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=config2.diff; charset=ISO-8859-1

--- linux-2.4.23-pre6/drivers/acpi/Config.in.orig	Mon Oct  6 05:35:24 2003
+++ linux-2.4.23-pre6/drivers/acpi/Config.in	Mon Oct  6 05:43:29 2003
@@ -32,7 +32,8 @@
     tristate     '  Toshiba Laptop Extras'	CONFIG_ACPI_TOSHIBA
     bool         '  Debug Statements'	CONFIG_ACPI_DEBUG
     bool         '  Relaxed AML Checking'	CONFIG_ACPI_RELAXED_AML
-  else if [ "$CONFIG_SMP" =3D "y" ]; then
+  else=20
+  	if [ "$CONFIG_SMP" =3D "y" ]; then
       define_bool CONFIG_ACPI_BOOT		y
     fi
   fi

--=-QtCayqDf4TmhutyAshrl
Content-Disposition: attachment; filename=config3.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=config3.diff; charset=ISO-8859-1

--- linux-2.4.23-pre6/drivers/acpi/Config.in.orig	Mon Oct  6 05:35:24 2003
+++ linux-2.4.23-pre6/drivers/acpi/Config.in	Mon Oct  6 05:44:40 2003
@@ -35,7 +35,6 @@
   else if [ "$CONFIG_SMP" =3D "y" ]; then
       define_bool CONFIG_ACPI_BOOT		y
     fi
-  fi
=20
   endmenu
=20

--=-QtCayqDf4TmhutyAshrl--

