Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272336AbTHNMzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272338AbTHNMzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:55:39 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:44649 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S272336AbTHNMzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:55:36 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B014053B5@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'Rik van Riel'" <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0.test 2 sysctl documentation update
Date: Thu, 14 Aug 2003 14:55:34 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C36263.59BCB6D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C36263.59BCB6D0
Content-Type: text/plain;
	charset="iso-8859-1"

Rik,
	Here's a patch against sysctl documentation.(abi doc).

Regards,
Fabian
 <<sysctl0803.diff>> 

------_=_NextPart_000_01C36263.59BCB6D0
Content-Type: application/octet-stream;
	name="sysctl0803.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sysctl0803.diff"

diff -Naur orig/Documentation/sysctl/README =
edited/Documentation/sysctl/README=0A=
--- orig/Documentation/sysctl/README	2003-07-27 17:07:20.000000000 =
+0000=0A=
+++ edited/Documentation/sysctl/README	2003-08-11 22:42:59.000000000 =
+0000=0A=
@@ -55,6 +55,7 @@=0A=
 by piece basis, or just some 'thematic frobbing'.=0A=
 =0A=
 The subdirs are about:=0A=
+abi/		execution domains & personalities=0A=
 debug/		<empty>=0A=
 dev/		device specific information (eg dev/cdrom/info)=0A=
 fs/		specific filesystems=0A=
diff -Naur orig/Documentation/sysctl/abi.txt =
edited/Documentation/sysctl/abi.txt=0A=
--- orig/Documentation/sysctl/abi.txt	1970-01-01 00:00:00.000000000 =
+0000=0A=
+++ edited/Documentation/sysctl/abi.txt	2003-08-11 22:41:29.000000000 =
+0000=0A=
@@ -0,0 +1,54 @@=0A=
+Documentation for /proc/sys/abi/* kernel version 2.6.0.test2=0A=
+	(c) 2003,  Fabian Frederick <ffrederick@users.sourceforge.net>=0A=
+=0A=
+For general info : README.=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+=0A=
+This path is binary emulation relevant aka personality types aka =
abi.=0A=
+When a process is executed, it's linked to an exec_domain whose=0A=
+personality is defined using values available from /proc/sys/abi.=0A=
+You can find further details about abi in =
include/linux/personality.h.=0A=
+=0A=
+Here are the files featuring in 2.6 kernel :=0A=
+=0A=
+- defhandler_coff=0A=
+- defhandler_elf=0A=
+- defhandler_lcall7=0A=
+- defhandler_libcso=0A=
+- fake_utsname=0A=
+- trace=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+defhandler_coff:=0A=
+defined value :=0A=
+PER_SCOSVR3=0A=
+0x0003 | STICKY_TIMEOUTS | WHOLE_SECONDS | SHORT_INODE=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+defhandler_elf:=0A=
+defined value : =0A=
+PER_LINUX=0A=
+0=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+defhandler_lcall7:=0A=
+defined value :=0A=
+PER_SVR4=0A=
+0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+defhandler_libsco:=0A=
+defined value:=0A=
+PER_SVR4=0A=
+0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+fake_utsname:=0A=
+Unused=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+trace:=0A=
+Unused=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=

------_=_NextPart_000_01C36263.59BCB6D0--
