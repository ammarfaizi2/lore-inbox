Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVKJXzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVKJXzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVKJXzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:55:11 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:50334 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932221AbVKJXzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:55:09 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 10 Nov 2005 23:55:01 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, hugh@veritas.com,
       lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC] sys_punchhole()
In-Reply-To: <1131666062.25354.41.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511102351130.24857@hermes-1.csi.cam.ac.uk>
References: <1131664994.25354.36.camel@localhost.localdomain> 
 <20051110153254.5dde61c5.akpm@osdl.org> <1131666062.25354.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Badari Pulavarty wrote:
> On Thu, 2005-11-10 at 15:32 -0800, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > We discussed this in madvise(REMOVE) thread - to add support 
> > > for sys_punchhole(fd, offset, len) to complete the functionality
> > > (in the future).
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-mm&m=113036713810002&w=2
> > > 
> > > What I am wondering is, should I invest time now to do it ?
> > 
> > I haven't even heard anyone mention a need for this in the past 1-2 years.
> > 
> > > Or wait till need arises ? 
> > 
> > A long wait, I suspect..
> > 
> 
> Okay. I guess, I will wait till someone needs it.
> 
> I am just trying to increase my chances of "getting my madvise(REMOVE)
> patch into mainline" :)
> 

It may be worth asking the Samba people if they want it given that Windows 
has such a function (but it is not a syscall, it is a fsctl - 
FSCTL_SET_ZERO_DATA), so Samba may want to have it, too...

And in case you care, NTFS already has such functionality (currently only 
used in error handling) and implementing the sys_punchole() fs-specific 
function for ntfs will therefore be trivial...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
