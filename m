Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293533AbSCCJVX>; Sun, 3 Mar 2002 04:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293534AbSCCJVN>; Sun, 3 Mar 2002 04:21:13 -0500
Received: from oe28.law9.hotmail.com ([64.4.8.85]:61958 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S293533AbSCCJU7>;
	Sun, 3 Mar 2002 04:20:59 -0500
X-Originating-IP: [66.108.23.161]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Patch to 2.4.18 to replace the missing rc4 patch
Date: Sun, 3 Mar 2002 04:20:48 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0042_01C1C26A.CC0CD700"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE287NoUDry420OPbgC00001f00@hotmail.com>
X-OriginalArrivalTime: 03 Mar 2002 09:20:54.0073 (UTC) FILETIME=[B7FB4290:01C1C294]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0042_01C1C26A.CC0CD700
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

    Since many people download the entire g or b zipped tarball of the
kernel I figured some would like to have a patch to replace the missing rc4
fix in their 2.4.18 source trees.  Consequently I've attached it here.

------=_NextPart_000_0042_01C1C26A.CC0CD700
Content-Type: application/octet-stream;
	name="2.4.18-missing-code-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2.4.18-missing-code-fix.patch"

diff -Naur linux-2.4.18/fs/binfmt_elf.c linux/fs/binfmt_elf.c=0A=
--- linux-2.4.18/fs/binfmt_elf.c	Mon Feb 25 14:38:08 2002=0A=
+++ linux/fs/binfmt_elf.c	Fri Mar  1 03:16:02 2002=0A=
@@ -564,6 +564,9 @@=0A=
 			// printk(KERN_WARNING "ELF: Ambiguous type, using ELF\n");=0A=
 			interpreter_type =3D INTERPRETER_ELF;=0A=
 		}=0A=
+	} else {=0A=
+		/* Executables without an interpreter also need a personality  */=0A=
+		SET_PERSONALITY(elf_ex, ibcs2_interpreter);=0A=
 	}=0A=
 =0A=
 	/* OK, we are done with that, now set up the arg stuff,=0A=

------=_NextPart_000_0042_01C1C26A.CC0CD700--
