Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130686AbRCEVhR>; Mon, 5 Mar 2001 16:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130692AbRCEVhF>; Mon, 5 Mar 2001 16:37:05 -0500
Received: from sheffield.concentric.net ([207.155.252.12]:35575 "EHLO
	sheffield.cnchost.com") by vger.kernel.org with ESMTP
	id <S130686AbRCEVgP>; Mon, 5 Mar 2001 16:36:15 -0500
Message-ID: <3AA406C7.CC1BDC4C@aerizen.com>
Date: Mon, 05 Mar 2001 13:36:07 -0800
From: John Silva <jps@aerizen.com>
Organization: None
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-14mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@serpentine.com>
CC: Yuval Krymolowski <yuvalk@macs.biu.ac.il>, linux-kernel@vger.kernel.org
Subject: Re: Can Linux 2.4.x boot from UDMA-100 disk ?
In-Reply-To: <Pine.LNX.4.21.0103042231110.1665-100000@yuval> <87y9ukych4.fsf@pelerin.serpentine.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am doing this very thing on linux 2.2.18.  My kernel has both the hd.c and
ide.c drivers installed.

I had to specify ide0=0x1f0 to the kernel to prevent the kernel's hd.c driver
from remapping the first two drives to hda/hdb.  With the ide0 setting the
kernel preserves the true partition mapping.  My boot partition is on
/dev/hde and my root is on /dev/hdg.

Since my UDMA 100 controller is an addon controller I had to instruct my
system's BIOS to specify boot order as ATA/SCSI, and to boot from "SCSI"
rather than HDD0.

-J.

Bryan O'Sullivan wrote:

> y> Would it be possible to boot kernel 2.4.x from the UDMA/100 drive?
>
> Yes.
>
> y> in http://www.linux-ide.org/ultra100.html it is not mentioned if
> y> the patches can help with boot.
>
> You shouldn't need Andre's patches.
>
>         <b
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

