Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263504AbUJ2V6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbUJ2V6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUJ2Vxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:53:47 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:24709 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263597AbUJ2VsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:48:15 -0400
Date: Fri, 29 Oct 2004 22:48:01 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes to fs/buffer.c?
In-Reply-To: <Pine.LNX.4.58.0410291343510.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0410292246300.24884@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410291516580.19494@hermes-1.csi.cam.ac.uk>
 <20041029133420.76a758b3.akpm@osdl.org> <Pine.LNX.4.58.0410291343510.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Linus Torvalds wrote:
> On Fri, 29 Oct 2004, Andrew Morton wrote:
> > Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > >
> > > Is it ok to export 
> > >  create_buffers() and to make __set_page_buffers() static inline and move 
> > >  it to include/linux/buffer.h?
> > 
> > ho, hum - if you must ;)
> > 
> > I'd be inclined to rename it to attach_page_buffers() or something though -
> > create_buffers() is a bit generic-sounding.
> 
> Also, I think we should at least start out limiting it to GPL-only usage. 
> Those page buffers are pretty intertwined with the VM usage, I'd hate to 
> see people think this is some kind of external interface..

Yes, sure.  I will use the _GPL version for the symbol export.  I only 
used the non-GPL-only form since create_empty_buffers() is simply exported 
and create_buffers() is kind of the same thing but does less...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
