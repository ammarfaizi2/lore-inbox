Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130636AbRAKMXt>; Thu, 11 Jan 2001 07:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRAKMXj>; Thu, 11 Jan 2001 07:23:39 -0500
Received: from colorfullife.com ([216.156.138.34]:38162 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130234AbRAKMXa>;
	Thu, 11 Jan 2001 07:23:30 -0500
From: Manfred <manfred@colorfullife.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <979216159.3a5da71fdc35b@colorfullife.com>
Date: Thu, 11 Jan 2001 07:29:19 -0500 (EST)
Cc: Manfred <manfred@colorfullife.com>, Russell King <rmk@arm.linux.org.uk>,
        Andrea Arcangeli <andrea@suse.de>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200101110734.f0B7Y1x01512@flint.arm.linux.org.uk> <979215027.3a5da2b3781d7@localhost> <20010111131005.A23611@gruyere.muc.suse.de>
In-Reply-To: <20010111131005.A23611@gruyere.muc.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 134.96.7.93
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitiere Andi Kleen <ak@suse.de>:

> On Thu, Jan 11, 2001 at 07:10:27AM -0500, Manfred wrote:
> > Zitiere Russell King <rmk@arm.linux.org.uk>:
> > > The API changed:
> > >  struct nfs_mount_data {
> > >         int             version;                /* 1 */
> > >         int             fd;                     /* 1 */
> > > -       struct nfs_fh   root;                   /* 1 */
> > > +       struct nfs2_fh  old_root;               /* 1 */
> > 
> > I don't see an API change:
> > the 2.2.17 "struct nfs_fs" and the 2.2.18 "struct nfs2_fh" are
> identical.
> 
> But it changed in 2.2.19pre, breaking nfs mount on i386. 
> 

-ECONFUSED.

2.2.17 struct nfs_fh is identical to 2.2.18 nfs2_fh and 2.2.19pre7 nfs2_fh

2.2.18 struct nfs_fh is a new structure for nfsV3, it doesn't exist in 2.2.17.
That structure is unusable on ARM.

Russel want's to change the new "struct nfs_fh" (from 2.2.18), and that change
is included in 2.2.19pre7. But that change breaks i386 nfs mount.

Could someone with an Alpha/Sparc/ARM compiler compile a test program with
"struct nfs_fh" from 2.2.18 and print the offset of nfs_fh.data?

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
