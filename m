Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUHZJSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUHZJSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUHZJSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:18:11 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:4768 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268074AbUHZJDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:03:18 -0400
Subject: Re: silent semantic changes with reiser4
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Spam <spam@tnonline.net>, Linus Torvalds <torvalds@osdl.org>,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
In-Reply-To: <20040825163225.4441cfdd.akpm@osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825152805.45a1ce64.akpm@osdl.org>
	 <112698263.20040826005146@tnonline.net>
	 <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
	 <1453698131.20040826011935@tnonline.net>
	 <20040825163225.4441cfdd.akpm@osdl.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Message-Id: <1093510983.23289.6.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 10:03:04 +0100
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 00:32, Andrew Morton wrote:
> Spam <spam@tnonline.net> wrote:
> >
> > > In other words, if reiserfs does something special, we should make 
> > > standard interfaces for doing that special thing, so that everybody can
> > > do it without stepping on other peoples toes.
> > 
> >   Agreed  that would be the best. But how much time and effort will it
> >   be
> 
> Zero.
> 
> We can add these new features tomorrow, as reiser4-only features, with a
> plan in hand to generalise them later.
> 
> -->>__if__<<-- we think these are features which Linux should offer.

Please don't forget that if the reiser4 features are merged as they are
now, then we will likely be stuck with the API reiser4 chooses.  There
will be tools that will rely on it springing up no doubt.

Moving the reiser4 features to VFS later is fine and good, but what if
the VFS doesn't want the same API for those features?  Either we would
have to allow reiser4 to continue providing the old API even though the
VFS now provides a new, shiny API or we would have to break all existing
API users on reiser4.  Things like "I rebooted into the latest kernel
and my computer failed to boot because essential app FOO failed to
access the reiser4 API - Help!" spring to mind.

Yes, I know I am painting a rather black picture here and I know you
might well say "screw apps", its been done plenty of times in Linux
kernel development before...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

