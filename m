Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSE3O33>; Thu, 30 May 2002 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSE3O32>; Thu, 30 May 2002 10:29:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35572 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313743AbSE3O32>; Thu, 30 May 2002 10:29:28 -0400
Subject: Re: [PATCH] 2.5.18 IDE 73
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <3CF622F0.4050304@evision-ventures.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 May 2002 16:32:53 +0100
Message-Id: <1022772774.12888.380.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-30 at 14:02, Martin Dalecki wrote:
> 1. util-linux doesn't cover half of the system utilities needed on
>     a sanely actual Linux system.
> 2. The Linux vendors have to apply insane number of patches to it
>     util it's moderately usable.

So now you have nothing better to do than insult someone whose code
works, is shipped in just about every distribution. Someone whose kernel
patches are almost without fail perfect first time.

You should learn from Andries not mock him.

> And after all it's rather trivial to iterate *all* disks present at boot
> by hand and just going through /dev/sdaxxx chains. SCSI allocates
> them consecutively anyway and there are typically not many ATA diskst around
> there.

You still need a way to talk all the disk devices. It might be that is
devfs /dev/disk, but in case it hasn't permeated your skull yet, in such
a situation then -devfs- would need such a list. We also have another
flaw here - we don't export the bit position of the partition/device
split on each device which puts lots of horrible code into user space
thats always going out of date

Oh and for /dev/disk/... to do labels and partitions it needs the
partition data in the list too, remarkably like we have it now actually.

Alan

