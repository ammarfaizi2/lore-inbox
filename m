Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130840AbQKNHxc>; Tue, 14 Nov 2000 02:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130848AbQKNHxX>; Tue, 14 Nov 2000 02:53:23 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:6008 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130840AbQKNHxG>;
	Tue, 14 Nov 2000 02:53:06 -0500
From: "LA Walsh" <law@sgi.com>
To: "Andries Brouwer" <aeb@veritas.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Subject: RE: IDE0 /dev/hda performance hit in 2217 on my HW - more info - maybe extended partitions
Date: Mon, 13 Nov 2000 23:21:42 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHGEJFCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20001114015834.A24158@veritas.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to be the output of vmstat that isn't matching things.  First it
says
it's getting near 10M/s, but if you divide 128M/27 seconds, it's more like
4.7.
So where is the time being wasted?  It's not in cpu either.

Now I look at hda7 where vmstat reported 2000-3000 blocks/sec.  Again, the
math
says it's a rate near 5m/s.  So it still doesn't make sense.



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Andries Brouwer
> Sent: Monday, November 13, 2000 4:59 PM
> To: LA Walsh
> Cc: lkml
> Subject: Re: IDE0 /dev/hda performance hit in 2217 on my HW - more info
> - maybe extended partitions
>
>
> On Mon, Nov 13, 2000 at 03:47:27PM -0800, LA Walsh wrote:
>
> > Some further information in response to a private email, I did
> hdparm -ti
> > under both
> > 2216 and 2217 -- they are identical -- this may be something weird
> > w/extended partitions...
>
> What nonsense. There is nothing special with extended partitions.
> Partitions influence the logical view on the disk, but not I/O.
>
> (But the outer rim of a disk is faster than the inner side.)
>
> Moreover, you report elapsed times
> 0:27, 0:22, 0:24, 0:28, 0:21, 0:24, 0:27
> where is this performance hit?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
