Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130325AbQK0XsH>; Mon, 27 Nov 2000 18:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130319AbQK0Xr7>; Mon, 27 Nov 2000 18:47:59 -0500
Received: from 173-ZARA-X24.libre.retevision.es ([62.82.243.173]:8713 "EHLO
        head.redvip.net") by vger.kernel.org with ESMTP id <S129931AbQK0Xrp>;
        Mon, 27 Nov 2000 18:47:45 -0500
Message-ID: <3A21A28C.6C1E2BB8@zaralinux.com>
Date: Mon, 27 Nov 2000 00:53:49 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Gianluca Anzolin <g.anzolin@inwind.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: console not working in linux
In-Reply-To: <20001126222828.A12137@dracula.home.intranet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianluca Anzolin wrote:
> 
> Hello
>         sorry if I'm mailing this twice, but there is a kernel bug in
> linux 2.2 and linux 2.4. Linux 2.0 is not affected. I tested also
> FreeBSD, OpenBSD, Windows 95 and DOS and they all work.
> 
>         The problem is that linux doesn't find the video card: after
> lilo has loaded the kernel the screen becomes black. The system boots
> regularily but the screen stays black forever.
> 
>         In this PC I haven't configured any framebuffer and there isn't
> X Window. The video card is a TRIDENT 9660 and it is integrated on the
> mainboard.
> 
>         I tried to access the system via ssh and I tried to issue the
> lspci -xvv command. You can find the output (along with the output of
> pciconf -l from FreeBSD) on http://www.gest.unipd.it/~iig0573/lspci.txt
> lspci can't find the video card; FreeBSD finds it on 0:9.0
> 
>         I tried then to boot with pci=direct, bios & conf1 (as somebody
> told me) but anything changed. I tried also vga framebuffer and to pass
> the vga=ask argument to the kernel. Nothing changed.
> 
>         With vga=ask the system asks to choose a video mode. The system
> can also scan all the video modes of the card. But if I choose any of
> them the screen becomes black. After some investigation I think the
> problem is in arch/i386/boot/video.S but I haven't the skills to debug &
> solve.
> 
>         Please, help me, I really hope to use linux on this PC...
> otherwise I must use something else.
> 
>         Thank you,
> 
>         Gianluca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Are you sure you have enabled virtual terminal and console support in
character devices, and vga text console in console drivers?

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
