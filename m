Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265420AbRFVSUm>; Fri, 22 Jun 2001 14:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265408AbRFVSUc>; Fri, 22 Jun 2001 14:20:32 -0400
Received: from [64.64.109.142] ([64.64.109.142]:26372 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S265364AbRFVSUM>; Fri, 22 Jun 2001 14:20:12 -0400
Message-ID: <3B338C2B.D036012F@didntduck.org>
Date: Fri, 22 Jun 2001 14:19:23 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: root@chaos.analogic.com,
        Schilling Richard <RSchilling@affiliatedhealth.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: For comment: draft BIOS use document for the kernel
In-Reply-To: <E15DV4q-0003qv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I could not find any reference to BIOS int 0x15, function 0x87, block-
> > move, used to copy the kernel to above the 1 megabyte real-mode
> > boundary. I think this is still used.
> 
> I dont think the kernel has ever used it. The path has always been to enter
> 32bit mode then relocate/uncompress the kernel, then run it

It's in arch/i386/boot/setup.S, after label bootsect_second.  It's only
used with bzImage kernels and the floppy bootsector.

--

				Brian Gerst
