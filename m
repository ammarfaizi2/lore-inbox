Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVBZSw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVBZSw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 13:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVBZSw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 13:52:29 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:39902 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261257AbVBZSwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 13:52:24 -0500
Date: Sat, 26 Feb 2005 11:08:21 -0800
From: Bukie Mabayoje <bukiemab@gte.net>
Subject: Re: EBDA Question
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <4220C925.59995262@gte.net>
MIME-version: 1.0
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
References: <91888D455306F94EBD4D168954A9457C01297B87@nacos172.co.lsil.com>
 <cubhu5$3jf$1@terminus.zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"H. Peter Anvin" wrote:

> Followup to:  <91888D455306F94EBD4D168954A9457C01297B87@nacos172.co.lsil.com>
> By author:    "Moore, Eric Dean" <Eric.Moore@lsil.com>
> In newsgroup: linux.dev.kernel
> >
> > EBDA - Extended Bios Data Area
> >
> > Does Linux and various boot loaders(lilo/grub/etc)
> > having any restrictions on where and how big
> > memory allocated in EBDA is? Is this
> > handled for 2.4/2.6 Kernels?
> >
> > Reason I ask is we are considering having
> > BIOS(for a SCSI HBA Controller) allocating
> > memory in EBDA for Firmware use.
> > We are concerned whether Linux would be writing
> > over this region of memory during the handoff
> > of BIOS to scsi lower layer driver loading.
> >
>
> In general, dropping the EBDA below 0x9a000 is probably a
> bad idea.  Recent Linux kernels and boot loaders should handle it,
> though.  Keep in mind that you might find yourself in serious trouble
> if you then have, for example, a PXE stack layered on top of your SCSI
> BIOS.

There are test software used in manufacturing  line that needs this DOS memory.

>
>
>         -hpa
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
