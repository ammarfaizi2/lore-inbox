Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSEHWHK>; Wed, 8 May 2002 18:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315393AbSEHWHJ>; Wed, 8 May 2002 18:07:09 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:2295 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S315388AbSEHWHI>; Wed, 8 May 2002 18:07:08 -0400
Date: Wed, 8 May 2002 18:07:06 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Dan Yocum <yocum@fnal.gov>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ns83820 bug.  [was Re: Poor NFS client performance on 2.4.18?]
Message-ID: <20020508180705.B14959@redhat.com>
In-Reply-To: <3CC86BDC.C8784EA2@fnal.gov> <shsu1pyppnz.fsf@charged.uio.no> <3CD6FE1E.A20384D@fnal.gov> <E174zP0-0007N9-00@charged.uio.no> <3CD7F385.BAA3870B@fnal.gov> <3CD7F8A2.24DF8433@fnal.gov> <3CD98837.16B32F84@fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrade to 0.17 (which is in 2.4.19-pre5 or so and later) and you should 
find the issue resolved.

		-ben

On Wed, May 08, 2002 at 03:19:03PM -0500, Dan Yocum wrote:
> Trond, et al.
> 
> You're right, it's a driver (ns83820) issue.  Strange that it only shows up
> when trying to execute an app that's mounted via NFS, but, whatever. 
> Running apps from the the NFS volumes with the eepro100 adapter that's on
> the machine works fine with the updated NFS_all patch applied.
> 
> Thanks, again,
> Dan
> 
> 
> Dan Yocum wrote:
> > 
> > Dan Yocum wrote:
> > >
> > > Trond Myklebust wrote:
> > > >
> > > > On Tuesday 7. May 2002 00:05, Dan Yocum wrote:
> > > > > Trond,
> > > > >
> > > > > OK, so backing out the rpc_tweaks dif fixed the performance problem,
> > > > > however, seems to have introduced another problem that appears to be
> > > > > stemming from the seekdir.dif.  Attempting to run an app from an IRIX
> > > > > client (that has the 32bitclients option set) freezes the NFS volume - one
> > > > > can't access it from the Linux side, anymore.
> > > > >
> > > > > You can read and write to the NFS volume *before* trying to run something
> > > > > from there, but not after.
> > > > >
> > > > > Ideas?
> > > >
> > > > That smells like another network driver bug. Have you tcpdumped the traffic
> > > > between client and server?
> > >
> > > Ah, that may be the case - the problem also exists with a Linux server as
> > > well... let me check, and I'll let you know.
> > 
> > I take that back - it's only hanging on the Linux server when the IRIX
> > server is already hung.
> 
> 
> -- 
> Dan Yocum
> Sloan Digital Sky Survey, Fermilab  630.840.6509
> yocum@fnal.gov, http://www.sdss.org
> SDSS.  Mapping the Universe.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"You will be reincarnated as a toad; and you will be much happier."
