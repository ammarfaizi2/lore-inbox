Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289677AbSAOVGa>; Tue, 15 Jan 2002 16:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289671AbSAOVGU>; Tue, 15 Jan 2002 16:06:20 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:43503 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289670AbSAOVGL>;
	Tue, 15 Jan 2002 16:06:11 -0500
Date: Tue, 15 Jan 2002 14:04:36 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
Message-ID: <20020115140436.L11251@lynx.adilger.int>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@math.psu.edu>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16QXbx-0000wa-00@starship.berlin> <3C448B01.6030003@zytor.com> <E16Qa0W-0001kH-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16Qa0W-0001kH-00@starship.berlin>; from phillips@bonn-fries.net on Tue, Jan 15, 2002 at 09:16:32PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 15, 2002  21:16 +0100, Daniel Phillips wrote:
> On January 15, 2002 09:03 pm, H. Peter Anvin wrote:
> > Daniel Phillips wrote:
> > > Encoding the numeric fields in ASCII/hex is a goofy wart on an otherwise
> > > nice  design.  What is the compelling reason?  Bytesex isn't it: we
> > > should just pick one or the other and stick with it as we do in Ext2.
> > > 
> > > Why don't we fix cpio to write a consistent bytesex?
> > 
> > Because we want to use existing tools.
> 
> It's a mistake not to fix this tool.  I'll post the cost in terms of bytes
> wasted shortly, pretty tough to argue with that, right?

Well, I doubt the difference will be more than a few bytes, if you compare
the cpio archive sizes after compression with gzip.

> > I don't think think this application alone is enough to add Yet Another 
> > Version of CPIO.  However, if there are more compelling reasons to do so 
> >   for CPIO backup reasons itself I guess we could write it up and add it 
> > to GNU cpio as "linux" format...
> 
> Oh, it is, really it is.  It's not just any application, and GNU already
> has its own verion of cpio.

But then every person who wants to build a kernel will have to have
the patched version of cpio until such a time it is part of the standard
cpio tool (which may be "never").  I would much rather use the currently
available tools than save 20 bytes off a 900kB kernel image.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

