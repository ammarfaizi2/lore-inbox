Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131131AbRCGSB1>; Wed, 7 Mar 2001 13:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131134AbRCGSBR>; Wed, 7 Mar 2001 13:01:17 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:13316 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S131131AbRCGSBD>; Wed, 7 Mar 2001 13:01:03 -0500
Date: Wed, 7 Mar 2001 10:00:39 -0800 (PST)
From: David Rees <drees@greenhydrant.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Helke <andreas.helke@lionbioscience.com>,
        <linux-kernel@vger.kernel.org>, <nfs@sourceforge.net>,
        <sg_info@lionbioscience.com>, <kirschh@lionbioscienc.com>
Subject: Re: [NFS] Re: :Redhat [Bug 30944] - Kernel 2.4.0 and Kernel 2.2.18:
 with some programs
In-Reply-To: <E14ahiC-0001JG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103070940480.12048-100000@spoke>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Alan Cox wrote:

> > Unfortunately the missing files in directory listings from SGI Irix
> > 6.5.9f NFS servers still persists with the  2.4 kernel - we used the
> > kernel 2.4.0 kernel that came with the Redhat 7.1beta
> > uname -a tells Linux test-ah1 2.4.0-0.99.11 #1 Wed Jan 24 16:07:17 EST
> > 2001 i686 unknown
>
> That is something I'd expect. I don't plan to merge the NFS changes into -ac
> just yet. There are simply too many other things in 2.4 more important than
> an Irix corner case right now.
>
> Irix at least used to have an export option to do mappings to keep clients that
> had 32/64bit inode problems happy. Do those help ?

The 32bitclients option?  In my testing, it didn't change a thing.

Interestingly, unlike the original bug report, I can't reproduce the bug
on all systems, but once it's triggered, I can reliably reproduce it.  On
one 2.4.2 system, one directory always fails to show up, on another, I
can't reproduce the bug in any directory.  Sometimes no files end up
missing, 1 file is missing, or 5-6 files are missing when doing a `ls *`
vs `ls`.

On 2.2.18, mounting with nfsvers=2 seems to fix the problem, on 2.4.2
mounting with nfsvers=2 makes no difference.

-Dave



