Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283441AbRK3ASe>; Thu, 29 Nov 2001 19:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283442AbRK3ASZ>; Thu, 29 Nov 2001 19:18:25 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20409 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283441AbRK3ASR>; Thu, 29 Nov 2001 19:18:17 -0500
Date: Thu, 29 Nov 2001 17:17:59 -0700
Message-Id: <200111300017.fAU0Hx704241@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org,
        Valentin Ziegler <ziegler@informatik.hu-berlin.de>
Subject: Re: IDE controller detection 2.4 +devfs
In-Reply-To: <20011130001138.78ab1242.rene.rebe@gmx.net>
In-Reply-To: <20011130001138.78ab1242.rene.rebe@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe writes:
> I like to rereport that the IDE Controllers get strange device-
> node-number in Linux-2.4 (currently vanilla 2.4.16) at least using DevFS.
> 
> I reported (~a year ago) that when I disable the primary channel of the
> on-board controller of the Asus-K7M (Irongate based) the second channel
> will be host1 - no host0 can be found.
> 
> My today's issue is our K6-2 based server with an Gigabyte Ali-Aladin5
> board. The on-board controller is host0 but the additional Promisse
> TX2 Ultra100 will be host2 ??? no host1 there ... :
> 
> server1:~ # l /dev/ide/
> total 0
> drwxr-xr-x   1 root     root            0 Jan  1  1970 .
> drwxr-xr-x   1 root     root            0 Jan  1  1970 ..
> drwxr-xr-x   1 root     root            0 Jan  1  1970 host0
> drwxr-xr-x   1 root     root            0 Jan  1  1970 host2

So what's the problem? It's a similar naming scheme as used for
SCSI. It doesn't matter if you have something plugged into a bus, the
host numbering doesn't change. This is a Feature[tm].

If you want to access your drives according to detection order, use
/dev/discs instead.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
