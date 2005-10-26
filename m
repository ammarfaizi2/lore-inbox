Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVJZJdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVJZJdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 05:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVJZJdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 05:33:40 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:26330 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932145AbVJZJdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 05:33:39 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [2.6-git PATCH] Fix for HFSPlus, should go in before 2.6.14!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       prw@ceiriog1.demon.co.uk
In-Reply-To: <Pine.LNX.4.61.0510261053300.1386@scrub.home>
References: <Pine.LNX.4.64.0510260817360.3412@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.61.0510261053300.1386@scrub.home>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Wed, 26 Oct 2005 10:33:31 +0100
Message-Id: <1130319211.8284.18.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-10-26 at 10:59 +0200, Roman Zippel wrote:
> On Wed, 26 Oct 2005, Anton Altaparmakov wrote:
> 
> > Please apply before you release 2.6.14 if at all possible as HFS+ is 
> > seriously borked without it...  I have now given up waiting for Roman to 
> > reply given my original mail to him was two weeks ago and you are about 
> > to release 2.6.14...
> 
> I haven't responded yet, because I didn't have the time to verify and test 
> the problem yet. It's not "seriously borked", it doesn't crash, it still 
> works and the problem is easily fixed by fsck, so it wasn't on the top of 
> my todo list.

That is fair enough.  It is high on my TODO list so I sent the patch
bypassing you (and you were still CC:-ed so you could object if you
wanted).

I didn't even know there is an fsck for HFS+ (the one in hfsplusutils is
read-only so not much use - now I have found out pdisk contains it but
pdisk is not found on i386 distributions, at least not on SUSE 9.3 which
I was using at the time).

Nowhere in the kernel documentation (not in the Kconfig and not in
Documentation/filesystems anyway) is there anything about hfsplus.
There is a mention of hfsutils but not hfsplusutils or pdisk...  Perhaps
a documentation update is on order?

For me this bug meant I could no longer copy files to the disk and
wasted a day that way as it was full even though I deleted files to make
space and I had to take it back home to fix things on OSX and take it
back to work the next day to copy the files on Linux...

Anyway, requiring an fsck after every umount definitely fits my
definition of seriously borked.  YMMV.  (-:

> The patch looks fine, although I'd probably prefered to move this kind of 
> initialization into a separate function, as it's duplicated right now.

What is stopping you from doing so at some later point in time?

Whenever my git pull shows me that patches have hit fs/ntfs/ I look at
them and change them if I don't like something and make a new commit.
Andrew pulls my git repository for each -mm so it gets in that way to
-mm and I submit regular-ish updates to Linus for inclusion so for small
things like that they just get queued until a bigger submit.  Anyway,
that's just how I work.  (-:

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

