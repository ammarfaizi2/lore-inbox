Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310546AbSCGVPC>; Thu, 7 Mar 2002 16:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310547AbSCGVOw>; Thu, 7 Mar 2002 16:14:52 -0500
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:62986 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S310546AbSCGVOk>;
	Thu, 7 Mar 2002 16:14:40 -0500
Date: Thu, 7 Mar 2002 23:15:10 +0200 (IST)
From: Matan <matan@svgalib.org>
To: Holger Lubitz <h.lubitz@internet-factory.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 160gb maxtor with promise ultra 100
In-Reply-To: <3C87C6CB.F05C3B96@internet-factory.de>
Message-ID: <Pine.LNX.4.21_heb2.09.0203072312010.1837-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Holger Lubitz wrote:

> hi,
> 
> recently i installed two 160gb maxtor drives. using the latest ac-kernel
> (.19-pre2-ac3), they were detected correctly. however, the promise ultra
> 100 (detected as pdc 20267) hangs at the partition check. last thing it
> prints is "hde:" and it's dead. however, if i connect the drives to the
> onboard piix3 ide, they are detected correctly, survive the partition
> check, and _do_ work as 160gb drives, but slow (piix3 only supports
> mdma2, no udma). if i boot the latest non-ac-kernel available on the
> machine (which is the not so recent 2.4.14) the drives are misdetected
> as only 137gb (of course, no 48 bit support) but otherwise the machine
> works, even with the drives connected to the promise.

I had something similar - with 2.4.17+ide patch and PDC20265. The kernel
hanged at exactly the same position. I moved the disk to hdg (master on
second channel, instead of first), and it works OK.


-- 
Matan Ziv-Av.                         matan@svgalib.org


