Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312586AbSDODa0>; Sun, 14 Apr 2002 23:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSDODaZ>; Sun, 14 Apr 2002 23:30:25 -0400
Received: from exchsmtp.via.com.tw ([61.13.36.4]:64526 "EHLO
	exchsmtp.via.com.tw") by vger.kernel.org with ESMTP
	id <S312586AbSDODaW>; Sun, 14 Apr 2002 23:30:22 -0400
Message-ID: <369B0912E1F5D511ACA5003048222B75A3C046@exchtp02.via.com.tw>
From: Shing Chuang <ShingChuang@via.com.tw>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2.4.19-pre6] via-rhine.c to support new VIA's nic chip
	 VT6105, V6105M (correct).
Date: Mon, 15 Apr 2002 11:31:10 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="BIG5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, I'm sure that there's no chip with device id 0x6100 have beend
produced. The device id 0x6100 is used on testing only.
The chip named VT86C100A has device id 0x3043, not 0x6100. And, we have no
chip named VT3043.

As I know, they are currnetly working on refining the driver of linuxfet, so
there will be a new driver will be seem very sooner.

Thanks.

> -----Original Message-----
> From: Urban Widmark [mailto:urban@teststation.com]
> Sent: Saturday, April 13, 2002 7:50 PM
> To: Shing Chuang
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: Re: [PATCH 2.4.19-pre6] via-rhine.c to support new VIA's nic
> chip VT6105, V6105M (correct).
> 
> 
> On Fri, 12 Apr 2002, Shing Chuang wrote:
> 
> >       This patch applied to linux kernel 2.4.19-per6 to 
> support VIA's new
> > NIC chip.
> >       However, VIA don't have any nic chip with pci device 
> id 0x6100 so far,
> > so this patch also remove the device ID 0x6100.
> 
> You are removing the entry for 0x3043, not 0x6100 ... Did you 
> mean to also
> change "0x1106, 0x6100" to "0x1106, 0x3043" ?
> 
> Older revision D-Link DFE530-TX NICs use a chip that 
> identifies itself as
> 0x3043. This patch will break those.
> 
> 0x3043 is listed in the VT86C100A03.pdf doc from 
ftp.via.com.tw. An older
vt86c100a.pdf from 1997 lists the id as 0x6100. Are you sure there are no
cards using 0x6100?


As you perhaps are aware VIA maintain their own linuxfet.c driver, which
is a modified version of the Donald Becker via-rhine.c driver in the
kernel.

http://www.viaarena.com/?PageID=71#lan
6105v10cVIA.zip seems to be the most recent.

If you look at that driver they use 0x30431106. And also that ReqTxAlign
is only on for the VT86C100A.

The driver itself has become quite ugly from all #ifdef'ing that goes on.
It even has two tables for detecting PCI cards, and the tables are not in
sync ... But whoever wrote it knows more than what you can find in the
public datasheets.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
