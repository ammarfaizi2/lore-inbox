Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265123AbSJaCfn>; Wed, 30 Oct 2002 21:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265124AbSJaCfn>; Wed, 30 Oct 2002 21:35:43 -0500
Received: from ip008.siteplanet.com.br ([200.245.54.8]:3588 "EHLO
	plutao.siteplanet.com.br") by vger.kernel.org with ESMTP
	id <S265123AbSJaCfl>; Wed, 30 Oct 2002 21:35:41 -0500
Subject: [PATCH 2.5] Linux v2.5.45 fix QT problems !
From: Fernando Alencar =?ISO-8859-1?Q?Mar=F3stica?= <famarost@unimep.br>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-gYXMYxmV8+/tIpe9gflI"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Oct 2002 23:46:44 -0200
Message-Id: <1036028805.1676.5.camel@nitrogenium>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gYXMYxmV8+/tIpe9gflI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

This patch fixed small problems with QT requires.


diff -urN linux-2.5.45-vanilla/Makefile linux-2.5.45/Makefile
--- linux-2.5.45-vanilla/Makefile       Wed Oct 30 23:36:53 2002
+++ linux-2.5.45/Makefile       Wed Oct 30 23:13:02 2002
@@ -635,7 +635,7 @@
 .PHONY: oldconfig xconfig menuconfig config \
        make_with_config

-scripts/kconfig/conf scripts/kconfig/mconf scripts/kconfig/qconf:
scripts/fixdep FORCE
+scripts/kconfig/conf scripts/kconfig/mconf: scripts/fixdep FORCE
        +@$(call descend,scripts/kconfig,$@)

 xconfig: scripts/kconfig/qconf
diff -urN linux-2.5.45-vanilla/scripts/kconfig/Makefile
linux-2.5.45/scripts/kconfig/Makefile
--- linux-2.5.45-vanilla/scripts/kconfig/Makefile       Wed Oct 30
23:37:02 2002
+++ linux-2.5.45/scripts/kconfig/Makefile       Wed Oct 30 23:27:04 2002
@@ -34,7 +34,7 @@

 $(obj)/qconf.o: $(obj)/.tmp_qtcheck

--include $(obj)/.tmp_qtcheck
+#-include $(obj)/.tmp_qtcheck

 # QT needs some extra effort...
 $(obj)/.tmp_qtcheck:


Because oldconfig/config/menuconfig don't depend on having
QT installed anymore.


Best Regards,

--=20
Fernando Alencar Mar=F3stica
Graduate Student, Computer Science
Linux Register User Id #281457

University Methodist of Piracicaba
Departament of Computer Science
home: http://www.unimep.br/~famarost

--=-gYXMYxmV8+/tIpe9gflI
Content-Disposition: attachment; filename=patch-2.5.45
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch-2.5.45; charset=ISO-8859-1

diff -urN linux-2.5.45-vanilla/Makefile linux-2.5.45/Makefile
--- linux-2.5.45-vanilla/Makefile	Wed Oct 30 23:36:53 2002
+++ linux-2.5.45/Makefile	Wed Oct 30 23:13:02 2002
@@ -635,7 +635,7 @@
 .PHONY: oldconfig xconfig menuconfig config \
 	make_with_config
=20
-scripts/kconfig/conf scripts/kconfig/mconf scripts/kconfig/qconf: scripts/=
fixdep FORCE
+scripts/kconfig/conf scripts/kconfig/mconf: scripts/fixdep FORCE
 	+@$(call descend,scripts/kconfig,$@)
=20
 xconfig: scripts/kconfig/qconf
diff -urN linux-2.5.45-vanilla/scripts/kconfig/Makefile linux-2.5.45/script=
s/kconfig/Makefile
--- linux-2.5.45-vanilla/scripts/kconfig/Makefile	Wed Oct 30 23:37:02 2002
+++ linux-2.5.45/scripts/kconfig/Makefile	Wed Oct 30 23:27:04 2002
@@ -34,7 +34,7 @@
=20
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
=20
--include $(obj)/.tmp_qtcheck
+#-include $(obj)/.tmp_qtcheck
=20
 # QT needs some extra effort...
 $(obj)/.tmp_qtcheck:

--=-gYXMYxmV8+/tIpe9gflI--

