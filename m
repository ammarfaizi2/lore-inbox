Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291532AbSBHKWE>; Fri, 8 Feb 2002 05:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291539AbSBHKVz>; Fri, 8 Feb 2002 05:21:55 -0500
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:8651 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S291532AbSBHKVk>; Fri, 8 Feb 2002 05:21:40 -0500
Date: Fri, 8 Feb 2002 05:21:34 -0500 (EST)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: <kmsmith@millipede.gpcc.itd.umich.edu>
To: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nfs@lists.sourceforge.net>, <nfsv4-wg@sunroof.eng.sun.com>
Subject: NFS version 4 at the University of Michigan
Message-ID: <Pine.SOL.4.33.0202080036010.1689-100000@rygar.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an announcement of the first public release of NFS version 4
for Linux, by the University of Michigan.  Up to this point, all of
our work has been done privately, but we are now hoping to involve
the open-source community at large.  Eventually, we hope to integrate
our NFS version 4 implementation into the Linux kernel proper, and
find a long-term maintainter for NFS version 4 (possibly one of the
current NFS maintainers, possibly one of us working in their spare
time).

To download a patch for the 2.4.4 kernel, please see:
http://www.citi.umich.edu/projects/nfsv4/feb_2002_rel/mainpatch.html

At this point, only the 2.4.4 kernel is supported.  (This is the kernel
we have been using for development).  A port to the 2.5.x series is in
the works, but we decided to go ahead and release the 2.4.4 patch now,
rather than delay the release to do the port.

Note!  At this point, the client should be fairly stable and ready for
tearing apart by the open-source community.  The server, on the other
hand, is another story.  If you do look at the server, please be
forewarned that it is not really ready for public consumption: it still
needs systematic auditing and cleanup.

We are hoping that this release will result in:

o More pairs of eyeballs to study the client code,
  find bugs, simplifications, etc.  If you audit a
  section of code but don't find any problems,
  please let us know anyway!

o Code contributions for anything on the client side
  at all.  I have tried to flag down well-defined
  projects with the label "TODO"; just grep through
  the source code to get an idea of what needs to be
  done.  If you do want to work on something, it is
  probably a good idea to write one of us beforehand,
  to make sure that no-one else is also working on it!

In addition to the TODO's, there are also a few totally
unimplemented protocol features which could be worked on:

  - support for extended (named) attributes, using Andreas
    Grunbacher's ea/acl patch as a starting point.  This is
    a very large project, since mapping between the Linux
    internal interfaces and the on-the-wire protocol is
    highly nontrivial.

  - support for ACL's.  One of our students has already done
    some work on this, but we have not integrated it into the
    patch yet.  Once it is integrated, there is still a
    little more work remaining here.

  - filesystem replication and migration.  This is another
    very large project which we haven't even had the chance
    to start.

  - recovery from server-side reboots.  I am working on this at
    the moment and hope to finish by early March, but if someone
    wants to help out, there is probably room for another
    contributor here.

o Testing, testing, testing.  It is impossible for a lab of our
  size to subject our implementation to nearly the level of testing
  that the open-source community can provide.  We can pass the
  standard Connectathon tests, but not much else is known.  The
  'fsx' tests are known to fail because we are still working in
  the 2.4.4 kernel and have not merged the fsx-related fixes which
  appeard in later kernels.  If anyone is willing to devise some
  more rigorous tests, it would help the project enormously!

o Discussions with the Linux community which will lead toward the
  eventual inclusion of NFS version 4 into the kernel proper.  One
  issue which must be addressed is integration with NFS v2/v3.  At
  the present time, we are using a codebase which is completely
  independent of NFS v2/v3.  This turned out to be more convenient
  for development, but for long-term maintainability, integration
  with earlier versions of NFS is the only thing which makes sense.
  Another issue is that the NFSv4 protocol seems to require minor
  changes to existing VFS interfaces; we hope to hash out the details
  with the kernel maintainers during the 2.5.x cycle.

The following people have contributed to our project:
  Kendrick Smith   <kmsmith@umich.edu>
  Andy Adamson     <andros@umich.edu>
  Jim Rees         <rees@umich.edu>
  Dug Song         <dugsong@monkey.org>
  Eric Kustarze    (now at Sun Microsystems)
  Jake Moilanen    (now at IBM)
  Chris Myers      <camyers@umich.edu>

The mailing list
  nfsv4-wg@citi.umich.edu
can be used to send mail to all of the NFSv4 developers at the University
of Michigan.

Funding has been generously provided by Sun Microsystems and Network
Appliance.

Disclaimer: This is development code which is incomplete in many ways,
and is not nearly to the point of being ready for the kernel.  Please
bear this in mind when playing with it, and have fun tearing apart our
code!

Cheers,
 Kendrick Smith
 Center for Information Technology and Integration, University of Michigan

