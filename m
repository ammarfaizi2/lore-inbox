Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131456AbQKZV7C>; Sun, 26 Nov 2000 16:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131513AbQKZV6x>; Sun, 26 Nov 2000 16:58:53 -0500
Received: from cips.inwind.it ([212.141.53.74]:7904 "EHLO relay3.inwind.it")
        by vger.kernel.org with ESMTP id <S131456AbQKZV6g>;
        Sun, 26 Nov 2000 16:58:36 -0500
Date: Sun, 26 Nov 2000 22:28:28 +0100
From: Gianluca Anzolin <g.anzolin@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: KERNEL BUG: console not working in linux
Message-ID: <20001126222828.A12137@dracula.home.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
	sorry if I'm mailing this twice, but there is a kernel bug in
linux 2.2 and linux 2.4. Linux 2.0 is not affected. I tested also
FreeBSD, OpenBSD, Windows 95 and DOS and they all work.

	The problem is that linux doesn't find the video card: after
lilo has loaded the kernel the screen becomes black. The system boots
regularily but the screen stays black forever.

	In this PC I haven't configured any framebuffer and there isn't
X Window. The video card is a TRIDENT 9660 and it is integrated on the
mainboard.

	I tried to access the system via ssh and I tried to issue the
lspci -xvv command. You can find the output (along with the output of
pciconf -l from FreeBSD) on http://www.gest.unipd.it/~iig0573/lspci.txt
lspci can't find the video card; FreeBSD finds it on 0:9.0

	I tried then to boot with pci=direct, bios & conf1 (as somebody
told me) but anything changed. I tried also vga framebuffer and to pass
the vga=ask argument to the kernel. Nothing changed. 

	With vga=ask the system asks to choose a video mode. The system
can also scan all the video modes of the card. But if I choose any of
them the screen becomes black. After some investigation I think the
problem is in arch/i386/boot/video.S but I haven't the skills to debug &
solve.

	Please, help me, I really hope to use linux on this PC...
otherwise I must use something else.

	Thank you,

	Gianluca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
