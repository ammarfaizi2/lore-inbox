Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWH2H3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWH2H3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 03:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWH2H3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 03:29:54 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:14263 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750869AbWH2H3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 03:29:53 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Conversion to generic boolean
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44F3952B.5000500@yahoo.com.au>
References: <44EFBEFA.2010707@student.ltu.se>
	 <20060828093202.GC8980@infradead.org>
	 <20060828171804.09c01846.akpm@osdl.org>  <44F3952B.5000500@yahoo.com.au>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 29 Aug 2006 08:29:38 +0100
Message-Id: <1156836578.26009.6.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 11:15 +1000, Nick Piggin wrote:
> Andrew Morton wrote:
> > On Mon, 28 Aug 2006 10:32:02 +0100
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > 
> >>On Sat, Aug 26, 2006 at 05:24:42AM +0200, Richard Knutsson wrote:
> >>
> >>>Hello
> >>>
> >>>Just would like to ask if you want patches for:
> >>
> >>Total NACK to any of this boolean ididocy.  I very much hope you didn't
> >>get the impression you actually have a chance to get this merged.
> > 
> > 
> > I was kinda planning on merging it ;)
> > 
> > I can't say that I'm in love with the patches, but they do improve the
> > situation.
> > 
> > At present we have >50 different definitions of TRUE and gawd knows how
> > many private implementations of various flavours of bool.
> > 
> > In that context, Richard's approach of giving the kernel a single
> > implementation of bool/true/false and then converting things over to use it
> > makes sense.  The other approach would be to go through and nuke the lot,
> > convert them to open-coded 0/1.
> 
> Well... we are programming in C here, aren't we ;)

Not sure whether this is meant in favour of one or the other but we are
not programming in C strictly speaking but in C99+gccisms and C99
includes _Bool...

ps. I am definitely in favour of a kernel wide boolean type and will
certainly refuse any patches that remove the NTFS boolean type and
replace it with an open-coded 0/1...  I can only imagine that most other
maintainers who presently define their own boolen types will do the
same...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://www.linux-ntfs.org/ & http://www-stu.christs.cam.ac.uk/~aia21/

