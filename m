Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130889AbRAWVTh>; Tue, 23 Jan 2001 16:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130913AbRAWVT1>; Tue, 23 Jan 2001 16:19:27 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:12811 "HELO mx01.nexgo.de")
	by vger.kernel.org with SMTP id <S130889AbRAWVTV>;
	Tue, 23 Jan 2001 16:19:21 -0500
Message-ID: <000c01c08581$ddd0d4e0$4983bd97@Homer>
From: "Adrian Glaubitz" <adi007@germanynet.de>
To: <linux-kernel@vger.kernel.org>
Subject: Bug in IA64 bootsector code ?
Date: Tue, 23 Jan 2001 22:16:36 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0009_01C0858A.269A4780"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C0858A.269A4780
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hello,

I was just browsing the kernel sources and discovered

something strange:

in file linux/arch/ia64/boot/bootloader.c, line 104:

it says "volative" but i guess "volatile" was meant,
I couldn't find that keyword in my gcc documentation
either.

#ifdef CONFIG_ITANIUM_ASTEP_SPECIFIC
 asm volative ("nop 0;; nop 0;; nop 0;;");
#endif /* CONFIG_ITANIUM_ASTEP_SPECIFIC */

Please tell me if this is a bug or just forget this mail when I err.

My kernel version is 2.4.0 patched as follows:

1. downloaded and unpacked linux-2.4.0-test11.tar.gz to /usr/src/linux
2. patched with patch-2.4.0-test12.gz (zcat patch-2.4.0-test12.gz | =
patch -p1)
3. patched with patch-2.4.0-prerelease.gz (zcat =
patch-2.4.0-prerelease.gz | patch -p1)
4. patched with prerelease-to-final.gz (zcat prerelease-to-final.gz | =
patch -p1)
5. patched with linux-2.4.0-reiserfs-3.6.25-patch.gz (zcat =
linux-2.4.0-reiserfs-3.6.25-patch.gz | patch -p1)

Kernel was downloaded from http://www.kernel.org, patches were =
downloaded from http://www.kernel.org,
ReiserFS patch was downloaded from =
ftp://ftp.namesys.com/pub/reiserfs-for-2.4/


Adrian Glaubitz

------=_NextPart_000_0009_01C0858A.269A4780
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4134.600" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I was just browsing the kernel sources =
and=20
discovered</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>something strange:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>in file =
linux/arch/ia64/boot/bootloader.c, line=20
104:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV><FONT face=3DArial =
size=3D2>
<DIV>it says "volative" but i guess "volatile" was meant,</DIV>
<DIV>I couldn't find that keyword in my gcc documentation</DIV>
<DIV>either.</DIV>
<DIV>&nbsp;</DIV>
<DIV>#ifdef CONFIG_ITANIUM_ASTEP_SPECIFIC<BR>&nbsp;asm volative ("nop =
0;; nop=20
0;; nop 0;;");<BR>#endif /* CONFIG_ITANIUM_ASTEP_SPECIFIC */</DIV>
<DIV>&nbsp;</DIV>
<DIV>Please tell me if this is a bug or just forget this mail when I =
err.</DIV>
<DIV>&nbsp;</DIV>
<DIV>My kernel version is 2.4.0 patched as follows:</DIV>
<DIV>&nbsp;</DIV>
<DIV>1. downloaded and unpacked linux-2.4.0-test11.tar.gz to=20
/usr/src/linux</DIV>
<DIV>2. patched with patch-2.4.0-test12.gz (zcat patch-2.4.0-test12.gz | =
patch=20
-p1)</DIV>
<DIV>
<DIV>3. patched with patch-2.4.0-prerelease.gz (zcat =
patch-2.4.0-prerelease.gz |=20
patch -p1)</DIV>
<DIV>
<DIV>4. patched with prerelease-to-final.gz (zcat prerelease-to-final.gz =
| patch=20
-p1)</DIV>
<DIV>5. patched with&nbsp;linux-2.4.0-reiserfs-3.6.25-patch.gz (zcat=20
linux-2.4.0-reiserfs-3.6.25-patch.gz | patch -p1)</DIV>
<DIV>&nbsp;</DIV>
<DIV>Kernel was downloaded from <A=20
href=3D"http://www.kernel.org">http://www.kernel.org</A>, patches were =
downloaded=20
from <A href=3D"http://www.kernel.org">http://www.kernel.org</A>,</DIV>
<DIV>ReiserFS patch was downloaded from <A=20
href=3D"ftp://ftp.namesys.com/pub/reiserfs-for-2.4/">ftp://ftp.namesys.co=
m/pub/reiserfs-for-2.4/</A></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Adrian Glaubitz</DIV></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0009_01C0858A.269A4780--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
