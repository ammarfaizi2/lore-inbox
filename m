Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVGERIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVGERIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 13:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVGERIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 13:08:12 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:50880 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261926AbVGERHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 13:07:17 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 5 Jul 2005 18:06:56 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Daniel Drake <dsd@gentoo.org>, David G?mez <david@pleyades.net>,
       Robert Love <rml@novell.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
In-Reply-To: <20050705154837.GA16512@tentacle.dhs.org>
Message-ID: <Pine.LNX.4.60.0507051804050.1458@hermes-1.csi.cam.ac.uk>
References: <42C65A8B.9060705@gentoo.org> <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>
 <42C72563.7040103@gentoo.org> <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>
 <42C7BF37.9010005@gentoo.org> <1120487242.11399.5.camel@imp.csi.cam.ac.uk>
 <42C9788F.50205@gentoo.org> <Pine.LNX.4.60.0507042008310.7572@hermes-1.csi.cam.ac.uk>
 <1120527203.18268.2.camel@vertex> <Pine.LNX.4.60.0507050855410.27724@hermes-1.csi.cam.ac.uk>
 <20050705154837.GA16512@tentacle.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005, John McCutchan wrote:
> On Tue, Jul 05, 2005 at 08:56:15AM +0100, Anton Altaparmakov wrote:
> > On Mon, 4 Jul 2005, John McCutchan wrote:
> > > On Mon, 2005-07-04 at 20:09 +0100, Anton Altaparmakov wrote:
> > > > On Mon, 4 Jul 2005, Daniel Drake wrote:
> > > > > Anton Altaparmakov wrote:
> > > > > > )-:  I have addressed the only things I can think off that could cause
> > > > > > the oops and below is the resulting patch.  Could you please test it?
> > > > > 
> > > > > Yeah!! After removing I_WILL_FREE stuff, that fixed both the oops *and* the
> > > > > hang. Everything works nicely now.
> > > > 
> > > > Great!  Thanks a lot for testing!  I will send a patch to Robert and 
> > > > Andrew in a minute with more comments added.
> > > 
> > > Nice work, I am going to have a closer look at the patch soon. Could you
> > > post the final patch at http://bugzilla.kernel.org/show_bug.cgi?id=4796
> > 
> > Thanks.  Now done.  But I am not sure about the white space.  I can't get 
> > anything sensible out of IE on Mac OS 9 which I am on at the moment.
> 
> Originally inotify had 2 functions that handled this. One that would
> build up a list of inodes to call remove_watch on, the other function
> would do the actual calling of remove_watch. This mirrored the other
> unmount paths. I'm wondering if it wouldn't be cleaner to revert back to
> that way?

That is certainly possible.  Out of curiosity, how did you anchor the 
inodes to your private list?  Or did you just have a dynamically allocated 
array of pointers to inodes?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
