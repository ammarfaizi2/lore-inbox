Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289395AbSA1Ub0>; Mon, 28 Jan 2002 15:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289375AbSA1UaQ>; Mon, 28 Jan 2002 15:30:16 -0500
Received: from port-213-20-128-55.reverse.qdsl-home.de ([213.20.128.55]:51210
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S289413AbSA1U3v> convert rfc822-to-8bit; Mon, 28 Jan 2002 15:29:51 -0500
Date: Mon, 28 Jan 2002 21:28:30 +0100 (CET)
Message-Id: <20020128.212830.846943574.rene.rebe@gmx.net>
To: alan@lxorguk.ukuu.org.uk
Cc: calin@ajvar.org, hassani@its.caltech.edu, linux-kernel@vger.kernel.org
Subject: Re: Athlon Optimization Problem
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <E16VIKU-0001f7-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.30.0201281452480.9637-200000@rtlab.med.cornell.edu>
	<E16VIKU-0001f7-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On: Mon, 28 Jan 2002 20:24:38 +0000 (GMT),
    Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Im still not convinced touching the register on the 266 chipset at 0x95 is
> correct. I now have several reports of boxes that only work if you leave it
> alone

We have a Druon-700 box based on the "Asus A7V" lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0a.0 Multimedia audio controller: Avance Logic Inc. ALS4000 Audio Chipset
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)

With an Athlon optimized 2.4.[16,17,18-pre7] all programs are getting
sig-11s everytime. Even mem=nopentium doesn't help, using generic i386
code generation seems to help. An Athlon optimized 2.4.4 kernel seems
also to run fine (and running memtest86 for some hours did not showed
a memory error ...).

> Alan

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
