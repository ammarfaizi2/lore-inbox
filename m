Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282778AbRLTJLg>; Thu, 20 Dec 2001 04:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282799AbRLTJLX>; Thu, 20 Dec 2001 04:11:23 -0500
Received: from mail.chs.ru ([194.154.71.136]:4106 "EHLO mail.unix.ru")
	by vger.kernel.org with ESMTP id <S282757AbRLTJLH>;
	Thu, 20 Dec 2001 04:11:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Jean-Francois Levesque <jfl@jfworld.net>, linux-kernel@vger.kernel.org
Subject: Re: UDMA problem with Maxtor 7200rpm disk
Date: Thu, 20 Dec 2001 12:10:51 +0300
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011219151636.50e930ac.jfl@jfworld.net>
In-Reply-To: <20011219151636.50e930ac.jfl@jfworld.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16GzE4-0002dJ-00@mail.unix.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
>
> I have a problem regarding my new Asus A7V266 board with VIA KT266 chipset.
>  Byron Stanoszek told me to ask my problem to this list so here it is :
>
> My hard drive is a Maxtor 5T030H3 ATA DISK drive (30 gig).  The problem is
> that I'm not able to read more than 7 MB/sec :

Hi,

I have exactly the same problem with 2.4.2 (RH Linux 7.1 - IIRC)
and IBM DTLA - 307040
I think the problem is in VIA82CXX support in 2.4.2
At least for vt8233
With current 2.4.16 (and 2.4.17-rc2) my disk works realy nice (37-38 Mb/s)

So I think you must get new kernel
and recompile it with
VIA82CXX support:
CONFIG_BLK_DEV_VIA82CXXX=y
> [root@xyz jfl]# /sbin/hdparm -d1 -X66 /dev/hda
btw please use 
/sbin/hdparm -d1 -X69 /dev/hda
instead (if you need UATA100)

			Best regards,
			Sergey S. Kostyliov <rathamahata@php4.ru>
