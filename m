Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265354AbRFVTFo>; Fri, 22 Jun 2001 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265493AbRFVTFe>; Fri, 22 Jun 2001 15:05:34 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53770 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265354AbRFVTFV>; Fri, 22 Jun 2001 15:05:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: For comment: draft BIOS use document for the kernel
Date: 22 Jun 2001 12:05:08 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9h04t4$ap9$1@cesium.transmeta.com>
In-Reply-To: <E15DV4q-0003qv-00@the-village.bc.nu> <Pine.LNX.3.95.1010622135228.3929C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1010622135228.3929C-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
>
> On Fri, 22 Jun 2001, Alan Cox wrote:
> 
> > > I could not find any reference to BIOS int 0x15, function 0x87, block-
> > > move, used to copy the kernel to above the 1 megabyte real-mode
> > > boundary. I think this is still used.
> > 
> > I dont think the kernel has ever used it. The path has always been to enter
> > 32bit mode then relocate/uncompress the kernel, then run it
> > 
> 
> Then how does 1.44 megabytes of data from a floppy disk (that won't
> fit below 1 megabyte), that is accessed in real-mode, ever get to
> above 1 megabyte where it can be decompressed?
> 
> I think LILO copies each buffer read from a below 1 Megabyte buffer
> (which is the only place the floppy can put its data via the BIOS),
> to above 1 megabyte using the BIOS block-move function.
> 

This is done by LILO, which isn't part of the kernel.  SYSLINUX, for
example, enters protected mode directly (like the kernel itself does).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
