Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319086AbSHMWgg>; Tue, 13 Aug 2002 18:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319087AbSHMWgg>; Tue, 13 Aug 2002 18:36:36 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:50331 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S319086AbSHMWgf>; Tue, 13 Aug 2002 18:36:35 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Wed, 14 Aug 2002 08:40:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15705.35537.28818.387927@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Various trouble in 2.5.31
In-Reply-To: message from Helge Hafting on Tuesday August 13
References: <3D58F932.4D87A904@aitel.hist.no>
X-Mailer: VM 7.03 under Emacs 21.2.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 13, helgehaf@aitel.hist.no wrote:
> Some problems and oddities I have seen:
> 
> * raid has trouble, even with 4k maximum bio's.
>   The bootup e2fsck complains that it can't find a valid
>   superblock on my raid-1 and raid-0 devices, although
>   mount has no trouble.  I get logged complaints about
>   e2fsck using outdated ioctl's for md.  Strange that
>   fsck should needs to know about raid devices.
>   Possibly a problem with e2fsck 1.27?

The warning about ioctl's is fairly bogus.  It gets reported for *any*
unknown ioctl, whether it looks like it might be raid related or not.
So I wouldn't worry about that.

I have a new collection of patches for md which break if fairly
thoroughly.  I am about to started testing/fixing and will
make sure that mkfs/fsck/mount work for raid{linear,0,1,5}.

Thanks,
NeilBrown
