Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136944AbRAHGK6>; Mon, 8 Jan 2001 01:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136929AbRAHGKr>; Mon, 8 Jan 2001 01:10:47 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:43442 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S136890AbRAHGKc>; Mon, 8 Jan 2001 01:10:32 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 01:03:46 -0500
Subject: [PATCH] 2.4.0-ac4 : fs/qnx4/inode.c
Message-ID: <20010108.010347.-134485.3.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary=--__JNP_000_5efd.1f15.5f2e
X-Juno-Line-Breaks: 9-6,7,9-32,33-32767
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_5efd.1f15.5f2e
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

Hello,
    While compiling 2.4.0-ac4, I receivied the following..Looks like a
typo...Patch is also below.
Regards,
Frank
 
inode.c: In function `qnx4_read_super':
inode.c:372: `sb' undeclared (first use in this function)
inode.c:372: (Each undeclared identifier is reported only once
inode.c:372: for each function it appears in.)
make[2]: *** [inode.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs/qnx4'
make[1]: *** [_modsubdir_qnx4] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [_mod_fs] Error 2
 
--- fs/qnx4/inode.c.old      Mon Jan  8 00:00:35 2001
+++ fs/qnx4/inode.c   Mon Jan  8 00:38:51 2001
@@ -369,7 +369,7 @@
      }
      s->s_op = &qnx4_sops;
      s->s_magic = QNX4_SUPER_MAGIC;
-     sb->s_maxbytes = 0x7FFFFFFF;
+     s->s_maxbytes = 0x7FFFFFFF;
 #ifndef CONFIG_QNX4FS_RW
      s->s_flags |= MS_RDONLY;      /* Yup, read-only yet */
 #endif
----__JNP_000_5efd.1f15.5f2e
Content-Type: text/html; charset=us-ascii  
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dwindows-1252" http-equiv=3DContent-=
Type>
<META content=3D"MSHTML 5.00.2314.1000" name=3DGENERATOR></HEAD>
<BODY bottomMargin=3D0 leftMargin=3D3 rightMargin=3D3 topMargin=3D0>
<DIV>Hello,</DIV>
<DIV>&nbsp;&nbsp;&nbsp; While compiling 2.4.0-ac4, I receivied the=20
following..Looks like a typo...Patch is also below.</DIV>
<DIV>Regards,</DIV>
<DIV>Frank</DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"></SPAN>&nbsp;</=
DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'">inode.c: In =
function=20
`qnx4_read_super':<BR>inode.c:372: `sb' undeclared (first use in this=20
function)<BR>inode.c:372: (Each undeclared identifier is reported only=20
once<BR>inode.c:372: for each function it appears in.)<BR>make[2]: *** [=
inode.o]=20
Error 1<BR>make[2]: Leaving directory `/usr/src/linux/fs/qnx4'<BR>make[1]: =
***=20
[_modsubdir_qnx4] Error 2<BR>make[1]: Leaving directory=20
`/usr/src/linux/fs'<BR>make: *** [_mod_fs] Error 2</SPAN><SPAN=20
style=3D"mso-fareast-font-family: 'MS Mincho'"><SPAN=20
style=3D"mso-fareast-font-family: 'MS Mincho'"></SPAN></SPAN></DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"><SPAN=20
style=3D"mso-fareast-font-family: 'MS Mincho'"></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"><SPAN=20
style=3D"mso-fareast-font-family: 'MS Mincho'">--- fs/qnx4/inode.c.old<SPAN=
=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN></SPAN><=
SPAN=20
lang=3DFR style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-language:=
 FR">Mon=20
Jan<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>8 00:00:35 2001<BR>+++=20
fs/qnx4/inode.c<SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp; </SPAN>Mon Jan=
<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>8 00:38:51 2001<BR></SPAN><SPAN=20
style=3D"mso-fareast-font-family: 'MS Mincho'">@@ -369,7 +369,7 @@<BR><SPAN=
=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>}<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>s-&gt;s_op =3D=20
&amp;qnx4_sops;<BR><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN><SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>s-&gt;s_magic =
=3D=20
QNX4_SUPER_MAGIC;<BR>-<SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&=
nbsp;=20
</SPAN>sb-&gt;s_maxbytes =3D 0x7FFFFFFF;<BR>+<SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>s-&gt;s_maxbytes=
 =3D=20
0x7FFFFFFF;<BR><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN>#ifndef=20
CONFIG_QNX4FS_RW<BR><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN><SPAN=20
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>s-&gt;s_flags |=
=3D=20
MS_RDONLY;<SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>/* Yup, read-only yet */<BR></SPAN><SPAN=20
style=3D"FONT-FAMILY: 'Times New Roman'; mso-fareast-font-family: 'MS =
Mincho'"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>#endif</SPAN><BR></DIV></SPAN></=
BODY></HTML>

----__JNP_000_5efd.1f15.5f2e--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
