Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315096AbSEHUTJ>; Wed, 8 May 2002 16:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315101AbSEHUTI>; Wed, 8 May 2002 16:19:08 -0400
Received: from heffalump.fnal.gov ([131.225.9.20]:30566 "EHLO fnal.gov")
	by vger.kernel.org with ESMTP id <S315096AbSEHUTH>;
	Wed, 8 May 2002 16:19:07 -0400
Date: Wed, 08 May 2002 15:19:03 -0500
From: Dan Yocum <yocum@fnal.gov>
Subject: ns83820 bug.  [was Re: Poor NFS client performance on 2.4.18?]
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
        linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3CD98837.16B32F84@fnal.gov>
MIME-version: 1.0
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13SGI_XFS_1.0.2 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3CC86BDC.C8784EA2@fnal.gov> <shsu1pyppnz.fsf@charged.uio.no>
 <3CD6FE1E.A20384D@fnal.gov> <E174zP0-0007N9-00@charged.uio.no>
 <3CD7F385.BAA3870B@fnal.gov> <3CD7F8A2.24DF8433@fnal.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond, et al.

You're right, it's a driver (ns83820) issue.  Strange that it only shows up
when trying to execute an app that's mounted via NFS, but, whatever. 
Running apps from the the NFS volumes with the eepro100 adapter that's on
the machine works fine with the updated NFS_all patch applied.

Thanks, again,
Dan


Dan Yocum wrote:
> 
> Dan Yocum wrote:
> >
> > Trond Myklebust wrote:
> > >
> > > On Tuesday 7. May 2002 00:05, Dan Yocum wrote:
> > > > Trond,
> > > >
> > > > OK, so backing out the rpc_tweaks dif fixed the performance problem,
> > > > however, seems to have introduced another problem that appears to be
> > > > stemming from the seekdir.dif.  Attempting to run an app from an IRIX
> > > > client (that has the 32bitclients option set) freezes the NFS volume - one
> > > > can't access it from the Linux side, anymore.
> > > >
> > > > You can read and write to the NFS volume *before* trying to run something
> > > > from there, but not after.
> > > >
> > > > Ideas?
> > >
> > > That smells like another network driver bug. Have you tcpdumped the traffic
> > > between client and server?
> >
> > Ah, that may be the case - the problem also exists with a Linux server as
> > well... let me check, and I'll let you know.
> 
> I take that back - it's only hanging on the Linux server when the IRIX
> server is already hung.


-- 
Dan Yocum
Sloan Digital Sky Survey, Fermilab  630.840.6509
yocum@fnal.gov, http://www.sdss.org
SDSS.  Mapping the Universe.
