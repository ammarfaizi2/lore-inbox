Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278940AbRKMUsP>; Tue, 13 Nov 2001 15:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278927AbRKMUsG>; Tue, 13 Nov 2001 15:48:06 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:19961 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278924AbRKMUrw>;
	Tue, 13 Nov 2001 15:47:52 -0500
Date: Tue, 13 Nov 2001 13:46:53 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Peter J . Braam" <braam@clusterfilesystem.com>
Cc: Andrew Morton <akpm@zip.com.au>, Steve Lord <lord@sgi.com>,
        Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-ID: <20011113134653.O1778@lynx.no>
Mail-Followup-To: "Peter J . Braam" <braam@clusterfilesystem.com>,
	Andrew Morton <akpm@zip.com.au>, Steve Lord <lord@sgi.com>,
	Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BF02702.34C21E75@zip.com.au>, <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net> <3BEFF9D1.3CC01AB3@zip.com.au> <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> <3BF02702.34C21E75@zip.com.au> <1005595583.13307.5.camel@jen.americas.sgi.com> <3BF03402.87D44589@zip.com.au> <20011112171705.Z1778@lynx.no> <20011112174005.N4281@lustre.dyn.ca.clusterfilesystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011112174005.N4281@lustre.dyn.ca.clusterfilesystem.com>; from braam@clusterfilesystem.com on Mon, Nov 12, 2001 at 05:40:05PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 12, 2001  17:40 -0700, Peter J . Braam wrote:
> The KML in fact doesn't record the writes.  I don't have a large KML,
> but it is easy to set one up.  Let me know if you need a hand.

We don't actually need to have the data contents, just the file sizes,
which I think the CLOSE records have, don't they?  The one thing I'm
unsure of is whether you zero the KML as it is "used", or does it keep
the data from past transactions?  At one time we were thinking about
using "punch" to reduce the actual file size, but I doubt that is in
place yet.

This is purely to measure the effects of repeated file creation, deletion,
updates in a real setting over a very long period (e.g. many months/years),
which is why setting something like this up today won't get us anywhere
(any large amount of activity would just be synthetic).

Do you think Ron Minnich or the folks at Tacitus would have a KML which
has been generated on a large server over a long period of time and not
erased?

> On Mon, Nov 12, 2001 at 05:17:05PM -0700, Andreas Dilger wrote:
> > On Nov 12, 2001  12:41 -0800, Andrew Morton wrote:
> > > BTW, I've been trying to hunt down a suitable file system aging tool.
> > > We're not very happy with Keith Smith's workload because the directory
> > > infomation was lost (he was purely studying FFS algorithmic differences
> > > - the load isn't 100% suitable for testing other filesystems / algorithms).
> > >   Constantin Loizides' tools are proving to be rather complex to compile,
> > >   drive and understand.
> > 
> > What _may_ be a very interesting tool for doing "real-world" I/O generation
> > is to use the InterMezzo KML (kernel modification log), which is basically
> > a 100% record of every filesystem operation done (e.g. create, write,
> > delete, mkdir, rmdir, etc).
> > 
> > Peter, do you have any very large KML files which would simulate the usage
> > of a filesystem over a long period of time, or would Tacitus have something
> > like that?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

