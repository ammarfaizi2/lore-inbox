Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265494AbRFVTZT>; Fri, 22 Jun 2001 15:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265496AbRFVTZJ>; Fri, 22 Jun 2001 15:25:09 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:24847 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265494AbRFVTY6>;
	Fri, 22 Jun 2001 15:24:58 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106221924.f5MJOcQ493255@saturn.cs.uml.edu>
Subject: Re: For comment: draft BIOS use document for the kernel
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 22 Jun 2001 15:24:38 -0400 (EDT)
Cc: root@chaos.analogic.com,
        RSchilling@affiliatedhealth.org (Schilling Richard),
        alan@lxorguk.ukuu.org.uk ('Alan Cox'),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <E15DV4q-0003qv-00@the-village.bc.nu> from "Alan Cox" at Jun 22, 2001 06:50:40 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> [somebody]

>> I could not find any reference to BIOS int 0x15, function 0x87,
>> block-move, used to copy the kernel to above the 1 megabyte
>> real-mode boundary. I think this is still used.
>
> I dont think the kernel has ever used it. The path has always been to
> enter 32bit mode then relocate/uncompress the kernel, then run it

There are several non-kernel BIOS users:

lilo
grub
syslinux
XFree86 (using virtual-8088 to run a video BIOS for a second card?)
dosemu?
loadlin?
the boot block that reads ext2 (in 1 kB -- damn what a hack)

