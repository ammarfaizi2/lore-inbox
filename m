Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292798AbSCDTrk>; Mon, 4 Mar 2002 14:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292802AbSCDTra>; Mon, 4 Mar 2002 14:47:30 -0500
Received: from ns1.cypress.com ([157.95.67.4]:60890 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S292798AbSCDTrM>;
	Mon, 4 Mar 2002 14:47:12 -0500
Message-ID: <3C83CF1F.9060901@cypress.com>
Date: Mon, 04 Mar 2002 13:46:39 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, 
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Ati range 128
In-Reply-To: <3C81F796.D36B2B45@sitoverde.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner: Scanned but not guaranteed against viruses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



gerry wrote:
> I have this problem with linux-2.4.18 and xfree4.2.0

> XFree86 Version 4.2.0 / X Window System
> (protocol Version 11, revision 0, vendor release 6600)
> Release Date: 18 January 2002
> Build Operating System: Linux 2.4.17 i686 [ELF] 
> (II) Loading sub module "vbe"
> (II) LoadModule: "vbe"
> (II) Loading /usr/X11R6/lib/modules/libvbe.a
> (II) Module vbe: vendor="The XFree86 Project"
> 	compiled for 4.2.0, module version = 1.0.0
> 	ABI class: XFree86 Video Driver, version 0.5
> (EE) R128(0): unknown reason for exception
> (II) R128(0): EAX=0x00004f00, EBX=0x00000000, ECX=0x00000000, EDX=0x00000000
> (II) R128(0): ESP=0x00000ffa, EBP=0x00000000, ESI=0x00000000, EDI=0x00002000
> (II) R128(0): CS=0x08aa, SS=0x0100, DS=0x0040, ES=0x0000, FS=0x0000, GS=0x0000
> (II) R128(0): EIP=0x0000ffff, EFLAGS=0x00033282
> (II) stack at 0x00001ffa:
>  00 06 00 00 00 32
> (II) R128(0): code at 0x00018a9f:
>  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> (EE) R128(0): cannot continue
> (II) R128(0): VESA BIOS not detected

Not sure why the VBE code did this.
It looks like a kernel oops though.
You might try running it through ksymoops.

> (II) R128(0): [drm] created "r128" driver at busid "PCI:1:0:0"
> (II) R128(0): [drm] added 8192 byte SAREA at 0xca8aa000
> (II) R128(0): [drm] mapped SAREA 0xca8aa000 to 0x40017000
> (II) R128(0): [drm] framebuffer handle = 0xd8000000
> (II) R128(0): [drm] added 1 reserved context for kernel
> (EE) R128(0): [dri] R128DRIScreenInit failed because of a version mismatch.
> [dri] r128.o kernel module version is 2.1.6 but version 2.2 or greater is needed.
> [dri] Disabling the DRI.


You need the new kernel module for the r128.
It's in the XFree86 sources, and I think the
-ac patches have it now.

	-Thomas


