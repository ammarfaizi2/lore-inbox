Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAIB6B>; Mon, 8 Jan 2001 20:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130559AbRAIB5n>; Mon, 8 Jan 2001 20:57:43 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:62083 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S129267AbRAIB53>; Mon, 8 Jan 2001 20:57:29 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 20:50:32 -0500
Subject: [PATCH] 2.4.0-ac4 : Removal of drivers/misc/misc.o
Message-ID: <20010108.205033.-271095.3.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary=--__JNP_000_1df8.26c9.418f
X-Juno-Line-Breaks: 9-6,7,10-27,29-34,35-32767
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_1df8.26c9.418f
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

Hello,
     The following patch removes drivers/misc/misc.o from the kernel
build. It appears that drivers/misc isn't used for anything, and should
be probably be removed.
Regards,
Frank

--- Makefile.old      Sun Jan  7 23:59:37 2001
+++ Makefile      Mon Jan  8 00:24:46 2001
@@ -121,7 +121,6 @@
 NETWORKS      =net/network.o
 DRIVERS          =drivers/block/block.o \
             drivers/char/char.o \
-           drivers/misc/misc.o \
             drivers/net/net.o \
             drivers/media/media.o
 LIBS       =$(TOPDIR)/lib/lib.a

--- drivers/Makefile.old      Sun Jan  7 23:59:48 2001
+++ drivers/Makefile  Mon Jan  8 20:25:57 2001
@@ -9,7 +9,7 @@
 mod-subdirs :=    dio mtd sbus video macintosh usb input telephony sgi
message/i2o message/fusion ide \
            scsi md ieee1394 pnp isdn atm fc4 net/hamradio i2c acpi
 
-subdir-y :=      block char net parport sound misc media cdrom
+subdir-y :=      block char net parport sound media cdrom
 subdir-m :=      $(subdir-y)
 
----__JNP_000_1df8.26c9.418f
Content-Type: text/html; charset=us-ascii  
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dwindows-1252" http-equiv=3DContent-=
Type>
<META content=3D"MSHTML 5.00.2314.1000" name=3DGENERATOR></HEAD>
<BODY bottomMargin=3D0 leftMargin=3D3 rightMargin=3D3 topMargin=3D0>
<DIV>Hello,</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; The following patch removes drivers/misc/misc=
.o=20
from the kernel build. It appears that drivers/misc isn't used for anything=
, and=20
should be probably be removed.</DIV>
<DIV>Regards,</DIV>
<DIV>Frank</DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'">--- Makefile.old<=
SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>Sun Jan<=
SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>7 23:59:37 2001<BR>+++ Makefile<=
SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>Mon Jan<=
SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>8 00:24:46 2001<BR>@@ -121,7 +121=
,6=20
@@<BR><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN>NETWORKS<SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>=3Dnet/network.o<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>DRIVERS<SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp; </SPAN><SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>=3Ddrivers/block/block.o \<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><SPAN=20
style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
</SPAN><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN>drivers/char/char.o=20
\<BR>-<SPAN=20
style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
</SPAN>drivers/misc/misc.o \<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><SPAN=20
style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
</SPAN><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN>drivers/net/net.o \<=
BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><SPAN=20
style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
</SPAN><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>drivers/media/media.o<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>LIBS<SPAN style=3D"mso-tab-count: =
1">=20
</SPAN><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>=3D$(TOPDIR)/lib/lib.a<BR><BR>--- drivers/Makefile.old<SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>Sun Jan<=
SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>7 23:59:48 2001<BR>+++=20
drivers/Makefile<SPAN style=3D"mso-tab-count: 1">&nbsp; </SPAN>Mon Jan<SPAN=
=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>8 20:25:57 2001<BR>@@ -9,7 +9,7=20
@@<BR><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN>mod-subdirs :=3D<SPAN=
=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp; </SPAN>dio mtd sbus video =
macintosh=20
usb input telephony sgi message/i2o message/fusion ide \<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>scsi md =
ieee1394=20
pnp isdn atm fc4 net/hamradio i2c acpi<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><BR>-subdir-y :=3D<SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>block char=
 net=20
parport sound misc media cdrom<BR>+subdir-y :=3D<SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>block char=
 net=20
parport sound media cdrom<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>subdir-m :=3D<SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>$(subdir-y)<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><BR></SPAN></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

----__JNP_000_1df8.26c9.418f--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
