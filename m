Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317494AbSFMIbI>; Thu, 13 Jun 2002 04:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317495AbSFMIbH>; Thu, 13 Jun 2002 04:31:07 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:18438 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317494AbSFMIbG>; Thu, 13 Jun 2002 04:31:06 -0400
Message-ID: <3D08583F.B40A4AFD@aitel.hist.no>
Date: Thu, 13 Jun 2002 10:30:55 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <Pine.GSO.4.21.0206122016140.16357-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 12 Jun 2002, Benjamin LaHaise wrote:
> 
> > On Wed, Jun 12, 2002 at 06:26:55PM -0400, Alexander Viro wrote:
> > > Not realistic - we have a recursion through the ->follow_link(), and
> > > a lot of stuff can be called from ->follow_link().  We _do_ have a
> > > limit on depth of recursion here, but it won't be fun to deal with.
> >
> > Perfection isn't what I'm looking for, rather just an approximation.
> > Any tool would have to give up on non-trivial recursion, or have
> 
> ... in which case it will be useless - anything callable from path_walk()
> will be out of its scope and that's a fairly large part of VFS, filesystems,
> VM and upper halves of block devices.

The automated checker may use hard-coded limits for recursions with
limited depth.  If follow_link stops after n iterations, tell
the checker about it and it will use that in its computations.

Helge Hafting
