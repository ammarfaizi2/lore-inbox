Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932726AbVHSUqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbVHSUqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVHSUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:46:42 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:7394 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932719AbVHSUql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:46:41 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 19 Aug 2005 21:46:28 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
Message-ID: <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> 
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
 <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2005, Linus Torvalds wrote:
> On Fri, 19 Aug 2005, Linus Torvalds wrote:
> > 
> >  - document this as a fundamental fact, and apply the ncpfs patch. Local 
> >    filesystems can still continue to use the generic helper functions 
> >    (all other users _are_ local filesystems).
> 
> Actually, looking at the ncpfs patch, I'd rather not apply that patch 
> as-is. It looks like it will totally disable symlink caching, which would 
> be kind of sad. Somebody willing to do the same thing NFS does?

It does disable link caching.  But I didn't make this up.  This is exactly 
what smbfs uses.  I just copied smbfs given ncpfs copies almost everything 
smbfs does anyway...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
