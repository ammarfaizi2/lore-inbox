Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275140AbRJAPEi>; Mon, 1 Oct 2001 11:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275139AbRJAPE2>; Mon, 1 Oct 2001 11:04:28 -0400
Received: from snowball.fnal.gov ([131.225.81.94]:18195 "EHLO
	snowball.fnal.gov") by vger.kernel.org with ESMTP
	id <S275140AbRJAPES>; Mon, 1 Oct 2001 11:04:18 -0400
Date: Mon, 1 Oct 2001 10:04:29 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <mjustice@austin.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
In-Reply-To: <E15nnXL-0007aB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0110011000160.4216-100000@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned earlier on this list, we saw similar corruption,
detectable by the fact that if you do a ls -R on the file system
there will be input/output errors due to inodes that are no longer
there, eventually.
We began with a system with a Seagate system drive (master, ide0), same
model as in Marvin's post..   IDE cd rom
as slave on the ide0 bus, and two IBM data drives on the ide1 bus.

The vendor eventually swapped out all the Seagate drives for
Western Digital ones, which does not make the problem go away,
but makes it much less frequent and harder to reproduce, but
at least there is something in /var/log/messages to show for it
whenever it does happen.  It is wrong to think this problem happens
only with Seagate drives.

Steve

------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

On Sun, 30 Sep 2001, Alan Cox wrote:
>
> 1.	Use multiword DMA not UDMA
> 2.	Use non seagate disks with that controller
>
> I am hopeful that serverworks will figure out what is up, but not every box
> sees it - and indeed they've yet to be able to reproduce it.
>
>
> Alan
>

