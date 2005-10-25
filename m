Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVJYIuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVJYIuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 04:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVJYIuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 04:50:05 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:30664 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932095AbVJYIuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 04:50:04 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH] Add notification of page becoming writable to VMA ops
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0510250919270.6403@goblin.wat.veritas.com>
References: <1130168619.19518.43.camel@imp.csi.cam.ac.uk>
	 <1130167005.19518.35.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com>
	 <7872.1130167591@warthog.cambridge.redhat.com>
	 <9792.1130171024@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com>
	 <1130227159.8169.5.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.61.0510250919270.6403@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 25 Oct 2005 09:49:49 +0100
Message-Id: <1130230190.8169.21.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 09:26 +0100, Hugh Dickins wrote:
> On Tue, 25 Oct 2005, Anton Altaparmakov wrote:
> > On Mon, 2005-10-24 at 20:11 +0100, Hugh Dickins wrote:
> > 
> > There really is quite a difference between mm/*.c in -mm and Linus
> > kernel at present.  Is all this planned to be merged as soon as 2.6.14
> > is out or is -mm just a playground for now with no mainline merge
> > intentions?
> 
> It certainly won't all be merged as soon as 2.6.14 is out, some of it
> has only just got into -mm.  Andrew's current intention is to merge
> the early part of the changes soonish after 2.6.14 gets out, but he's
> not likely to merge it all into 2.6.15.

Ok, sounds good.  As long as they at least start converging...

> But we aren't using -mm as a playground: it is likely to go forward,
> provided it doesn't show regressions of some kind while it's in -mm.

Cool.

> > Just asking so I know whether to work against stock kernels or -mm for
> > the moment...
> 
> I'd recommend -mm for now.

Great, thanks, will do.

> page_mkwrite will want a spell in there too, won't it?

Sure.  But if the other mm changes in -mm were not going forward it
would be a little silly to get page_mkwrite to work there only to have
to rewrite it in order to get it merged...

If Linus really is going to release .14 in the next few days,
page_mkwrite is never going to make it into .15 anyway, no matter
what...  But .16 would be a realistic target I would have thought which
seems to fit in nicely with the plans for -mm.  (-:

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

