Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293226AbSBWV6n>; Sat, 23 Feb 2002 16:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293224AbSBWV6g>; Sat, 23 Feb 2002 16:58:36 -0500
Received: from mail.uklinux.net ([80.84.72.21]:9485 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S293220AbSBWV6S>;
	Sat, 23 Feb 2002 16:58:18 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Sat, 23 Feb 2002 22:00:07 +0000
From: Chris Sykes <chris@sykes.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Re: floppy in 2.4.17
Message-ID: <20020223220007.A461@cooper>
In-Reply-To: <20020223160544.A1905@werewolf.able.es> <20020223184916.GA1518@chiara.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 07:49:16PM +0100, Heinz Diehl wrote:
> On Sat Feb 23 2002, J.A. Magallon wrote:
> 
> > I am getting problems with floppy drive in 2.4.17.
> > All started with floppy not working in 18-rc4, went back to 17
> > and still does not work. Just plain 2.4.17, no patching.
>  
> > mkfs -v -t ext2 /dev/fd0 gives:
>  
> > mke2fs 1.26 (3-Feb-2002)
> > mkfs.ext2: bad blocks count - /dev/fd0
> 
> Exactly the same thing here.

Yet another meetoo.

I also experience hard lockups when writing to the floppy drive (fdformat,
dd etc.) , nothing in my logs though.

... Hmm
Do you happen to have the NVidia kernel module loaded when the hangs occur?
More specifically, is the module being used?  From limited (fd is too
sloooowwww) I can dd, fdformat etc just fine under console, with or without
NVidia module loaded.  If I startx during fdformat then machine will lock
hard.  I have to pull the power cord for a few seconds to get the box
working again.

FYI:
sh-2.05# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:09.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG
[Mystique] (rev 03)
00:0b.0 Multimedia audio controller: Platform Technologies, Inc. AGOGO
sound chip (aka ESS Maestro 1) (rev 10)
00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
00:0f.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS)
(rev a3)

Xfree86 4.2.0
NVIDIA_kernel-1.0-1251 (I know it's old but it's the only release that 
will give me GL with xinerama enabled)

-- 
Chris Sykes

