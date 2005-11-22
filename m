Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVKVUBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVKVUBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVKVUBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:01:04 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:31381 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964784AbVKVUBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:01:02 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 22 Nov 2005 20:00:58 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Chris Adams <cmadams@hiwaay.net>, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
In-Reply-To: <20051122195201.GG31823@thunk.org>
Message-ID: <Pine.LNX.4.64.0511221955130.7002@hermes-1.csi.cam.ac.uk>
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net>
 <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk>
 <20051122171847.GD31823@thunk.org> <Pine.LNX.4.64.0511221921530.7002@hermes-1.csi.cam.ac.uk>
 <20051122195201.GG31823@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Theodore Ts'o wrote:
> On Tue, Nov 22, 2005 at 07:25:20PM +0000, Anton Altaparmakov wrote:
> > > > The standards are insufficient however.  For example dealing with named 
> > > > streams or extended attributes if exposed as "normal files" would 
> > > > naturally have the same st_ino (given they are the same inode as the 
> > > > normal file data) and st_dev fields.
> > > 
> > > Um, but that's why even Solaris's openat(2) proposal doesn't expose
> > > streams or extended attributes as "normal files".  The answer is that
> > > you can't just expose named streams or extended attributes as "normal
> > > files" without screwing yourself.
> > 
> > Reiser4 does I believe...
> 
> Reiser4 violates POSIX.  News at 11....
> 
> > I was not talking about Solaris/UFS.  NTFS has named streams and extended 
> > attributes and both are stored as separate attribute records inside the 
> > same inode as the data attribute.  (A bit simplified as multiple inodes 
> > can be in use for one "file" when an inode's attributes become large than 
> > an inode - in that case attributes are either moved whole to a new inode 
> > and/or are chopped up in bits and each bit goes to a different inode.)
> 
> NTFS violates POSIX.  News at 11....

What is your point?  I personally couldn't care less about POSIX (or any 
other simillarly old-fashioned standards for that matter).  What counts is 
reality and having a working system that does what I want/need it to do.  
If that means violating POSIX, so be it.  I am not going to burry my head 
in the sand just because POSIX says "you can't do that".  Utilities can be 
taught to work with the system instead of blindly following standards.  

And anyway the Linux kernel defies POSIX left, right, and centre so if you 
care that much you ought to be off fixing all those violations...  (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
