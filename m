Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131604AbRCSUDX>; Mon, 19 Mar 2001 15:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131609AbRCSUDE>; Mon, 19 Mar 2001 15:03:04 -0500
Received: from smtp2.sentex.ca ([199.212.134.9]:34313 "EHLO smtp2.sentex.ca")
	by vger.kernel.org with ESMTP id <S131604AbRCSUCu>;
	Mon, 19 Mar 2001 15:02:50 -0500
Message-ID: <3AB66449.5F5C673F@coplanar.net>
Date: Mon, 19 Mar 2001 14:55:53 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Moore <timothymoore@bigfoot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org> <3AB65C51.3DF150E5@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Moore wrote:

> quintaq@yahoo.co.uk wrote:
> > I have an IBM DTLA 307030 (ATA 100 / UDMA 5) on an 815e board (Asus CUSL2), which has a PIIX4 controller.
> > ...
> > My problem is that (according to hdparm -t), I never get a better transfer rate than approximately 15.8 Mb/sec.  I achieve this when DMA is enabled, - without it I fall back to about 5 Mb /sec.  No amount of fiddling with other hdparm settings makes any difference.
> > ...
>
> 15MB/s for hdparm is about right.

You should be able to get about 30 MB/s at the start of the disk (zone 0) according to IBM's datasheet at

http://ssdweb01.storage.ibm.com/techsup/hddtech/prodspec/dtla_spw.pdf

so if you were testing say /dev/hda1 which is at the start of the disk it should be faster.

Try hdparm -i /dev/hda (or whatever) .. . note the reported MaxMultSect= value,
and put it in place of X in command:

hdparm -u 1 -d 1 -m X -c 1 /dev/hda

Cheers,

Jeremy

PS - please let me know if this fixed your problem, since I have a system
with the same motherboard.

