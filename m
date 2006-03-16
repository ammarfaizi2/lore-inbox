Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752397AbWCPQkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbWCPQkv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbWCPQkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:40:51 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:10149 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752394AbWCPQku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:40:50 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 16 Mar 2006 16:39:52 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Christoph Hellwig <hch@infradead.org>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
In-Reply-To: <20060316163001.GA7222@infradead.org>
Message-ID: <Pine.LNX.4.64.0603161633270.31173@hermes-2.csi.cam.ac.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
 <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net>
 <20060316163001.GA7222@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Christoph Hellwig wrote:
> On Thu, Mar 16, 2006 at 08:29:51AM -0800, Randy.Dunlap wrote:
> > On Thu, 16 Mar 2006 16:01:30 +0000 Christoph Hellwig wrote:
> > 
> > > > The patch implements TRUE and FALSE in include/linux/kernel.h and removes all
> > > > the private versions.
> > > > 
> > > > The patch also kills off a few private implementations of NULL.
> > > 
> > > NACK.  Just kill them all and use 0/1

NACK to your NACK.  (-;

> > nah, the only place that using symbolic names for true and false
> > is a problem is when someone #defines or enums them bassackwards.
> 
> it makes the code longer and harder to read.

I could not disagree more.  It does _exactly_ the opposite.  It makes the 
code much easier to read but obviously you perceive it differently...  I 
guess it is very much a matter of taste rather than anything else.

For me, black and white is much simpler than shades of grey and whilst you 
can emulate black and white with shades of grey it is still more effort to 
parse than true black and white.

Certainly I refuse to have my booleans (in the kernel or anywhere else) 
converted to 0 and 1 but I am all for unifying to a single boolean type 
across the kernel, so this patch gets a big ACK from me.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
