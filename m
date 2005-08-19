Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVHSVjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVHSVjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbVHSVjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:39:13 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:23254 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932718AbVHSVjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:39:11 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 19 Aug 2005 22:39:03 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <Pine.LNX.4.58.0508191352540.3412@g5.osdl.org>
Message-ID: <Pine.LNX.4.60.0508192220440.7312@hermes-1.csi.cam.ac.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> 
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
 <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
 <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0508191352540.3412@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2005, Linus Torvalds wrote:
> On Fri, 19 Aug 2005, Anton Altaparmakov wrote:
> > It does disable link caching.  But I didn't make this up.  This is exactly 
> > what smbfs uses.  I just copied smbfs given ncpfs copies almost everything 
> > smbfs does anyway...
> 
> Can you test whether the untested test-patch I sent out seems to work for 
> your case that bugs out? You'll probably get a few new "initialization 
> from incompatible pointer type" warnings, but I do believe that they 
> should be harmless at least on normal architectures.

Yes, sure.  I have applied your patch to our 2.6.11.4 tree (with the one 
liner change I emailed you just now) and have kicked off a compile.  I am 
afraid the actual testing will have to wait for tomorrow as I was actually 
on the way to bed and the make modules is taking forever or at least 
longer than I can keep my eyes open...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
