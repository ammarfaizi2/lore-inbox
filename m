Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSFTGfQ>; Thu, 20 Jun 2002 02:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSFTGfP>; Thu, 20 Jun 2002 02:35:15 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:15072 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318128AbSFTGfO>; Thu, 20 Jun 2002 02:35:14 -0400
Date: Thu, 20 Jun 2002 08:07:09 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: (2.5.23) buffer layer error at buffer.c:2326
In-Reply-To: <3D10E358.D82DB604@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206200804210.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Andrew Morton wrote:

> Zwane Mwaikambo wrote:
> > 
> > The ide drive holding the mounted filesystem dropped out of DMA and then
> > spewed the following a number of times. Anyone interested?
> > 
> >  buffer layer error at buffer.c:2326
> 
> So we had a non-uptodate buffer against an uptodate page.  Were
> there any other messages in the logs?  I'd have expected a
> "buffer IO error" to come out first?

end_request: I/O error, dev 03:00, sector 180247
Buffer I/O error on device ide0(3,1), logical block 90123
EXT3-fs error (device ide0(3,1)): ext3_get_inode_loc: unable to read inode block - inode=22484, block=90123
EXT3-fs error (device ide0(3,1)) in ext3_reserve_inode_write: IO failure
EXT3-fs error (device ide0(3,1)) in ext3_new_inode: IO failure
hda: ide_dma_intr: status=0x51 [ drive ready seek complete error ] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error ] , CHS=181/11/14, sector=180247

Yep i got em all.

Cheers,
	Zwane Mwaikambo
-- 
http://function.linuxpower.ca
		

