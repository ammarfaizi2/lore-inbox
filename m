Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265482AbRFVSB3>; Fri, 22 Jun 2001 14:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265363AbRFVSBT>; Fri, 22 Jun 2001 14:01:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265482AbRFVSBL>; Fri, 22 Jun 2001 14:01:11 -0400
Date: Fri, 22 Jun 2001 14:01:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Schilling Richard <RSchilling@affiliatedhealth.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: For comment: draft BIOS use document for the kernel
In-Reply-To: <E15DV4q-0003qv-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010622135228.3929C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001, Alan Cox wrote:

> > I could not find any reference to BIOS int 0x15, function 0x87, block-
> > move, used to copy the kernel to above the 1 megabyte real-mode
> > boundary. I think this is still used.
> 
> I dont think the kernel has ever used it. The path has always been to enter
> 32bit mode then relocate/uncompress the kernel, then run it
> 

Then how does 1.44 megabytes of data from a floppy disk (that won't
fit below 1 megabyte), that is accessed in real-mode, ever get to
above 1 megabyte where it can be decompressed?

I think LILO copies each buffer read from a below 1 Megabyte buffer
(which is the only place the floppy can put its data via the BIOS),
to above 1 megabyte using the BIOS block-move function.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


