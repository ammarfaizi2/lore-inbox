Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSIINpd>; Mon, 9 Sep 2002 09:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSIINpc>; Mon, 9 Sep 2002 09:45:32 -0400
Received: from triton.neptune.on.ca ([205.233.176.2]:13803 "EHLO
	triton.neptune.on.ca") by vger.kernel.org with ESMTP
	id <S316541AbSIINpb>; Mon, 9 Sep 2002 09:45:31 -0400
Date: Mon, 9 Sep 2002 09:50:17 -0400 (EDT)
From: Steve Mickeler <steve@neptune.ca>
X-X-Sender: steve@triton.neptune.on.ca
To: Oktay Akbal <oktay.akbal@s-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md multipath with disk missing ?
In-Reply-To: <Pine.LNX.4.44.0209091537020.12771-100000@omega.s-tec.de>
Message-ID: <Pine.LNX.4.44.0209090948430.12095-100000@triton.neptune.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oktay,

You should really be using devfs in a situation such as yours, where you
need device name consistency during reboots.

On Mon, 9 Sep 2002, Oktay Akbal wrote:

> > > Does this only work with raid-autodetection ?
> > > When no autodetection is done and a drive is missing, would a raidstart
> > > kill the raid, since the drives are now available with other devices (sda
> > > instead of former sdb...) ?
> >
> > I don't understand your question, sorry.
>
> Example:
>
> We have sda - sdb (8 drives) and setup up a raidtab to tell linux that
> sda and sde are the same sdc - sdd etc.
> Now for some random error the server restarts and the former sda (path to
> that drive) is no longer available. So now we have sda,sdb...sdg.
> We do not use autodetect, but raidstart to activate the raid.
>
> now since the former sda is missing the raidtab does not reflect the
> actual setup. The raidtab would read, that sda and sdb are the same
> drive, which is not true in that case.
>
> (The device-ordering would not be right for a real setup, but take it as
> an example and assume sda-sde sdb-sdf...)
>
> Would the superblock prevent the wrong use of devices ?
> (With raid-configuration setup on top of multipathing ?)
>
>
>
>
> Oktay Akbal
> S-Tec Datenverarbeitung GmbH
> Feuerbachstr. 8
> 68163 Mannheim
> Tel: 0621-4185070
> Fax: 0621-4185071
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



[-] Steve Mickeler [ steve@neptune.ca ]

[|] Todays root password is brought to you by /dev/random

[+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF


