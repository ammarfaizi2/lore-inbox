Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVJXPti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVJXPti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVJXPti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:49:38 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:52394 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751115AbVJXPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:49:37 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: what happened to page_mkwrite? - was: Re: page_mkwrite seems
	broken
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0510241625230.4112@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com>
	 <1130167005.19518.35.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.61.0510241625230.4112@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 24 Oct 2005 16:49:12 +0100
Message-Id: <1130168952.19518.49.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-10-24 at 16:36 +0100, Hugh Dickins wrote:
> On Mon, 24 Oct 2005, Anton Altaparmakov wrote:
> > On Wed, 2005-02-09 at 14:28 +0000, Hugh Dickins wrote:
> > > On Fri, 4 Feb 2005, Hugh Dickins wrote in another thread:
> > > > Isn't this exactly what David Howells' page_mkwrite stuff in -mm's
> > > > add-page-becoming-writable-notification.patch is designed for?
> > > > 
> > > > Though it looks a little broken to me as it stands (beyond the two
> > > > fixup patches already there).  I've not found time to double-check
> .....
> > 
> > What happened with page_mkwrite?  It seems to have disappeared both from
> > -mm and generally from the face of the earth...
> 
> page_mkwrite??  No, never heard of it round here, you must be mistaken ;)

(-:

> But seriously, Andrew dropped it from 2.6.13-rc5-mm1, for expedient reasons:
> - Dropped cachefs and the cachefs-for-AFS patches.  These get in the way of
>   memory management testing a bit, and they're being redone anyway.
> 
> So Andrew's 2.6.13-rc4-mm1 directory should contain its last public state
> (by which time I'd fixed up those various things I'd found to be broken).

Right, thanks.  I was wondering whether they had been fixed.

> But David may have redone a lot since then, I don't know: he's the one
> to ask.  (And I'm afraid I've done my best to make the old patch not
> apply to current -mm.)

That can be fixed, if David has not done it already...  (-:

This is what I am working on in ntfs as my top priority at present, so I
really want to get it fixed and merged and I am willing to put in the
time necessary to make it happen as I really hate having to instantiate
holes on read access for files with logical blocks of size above
PAGE_{CACHE_,}SIZE, it just feels wrong...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

