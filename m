Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbTLOTxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 14:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTLOTwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 14:52:41 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:53167 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP id S263880AbTLOTwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 14:52:35 -0500
Date: Mon, 15 Dec 2003 19:52:32 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
In-Reply-To: <20031210144842.A24414@lists.us.dell.com>
Message-ID: <Pine.SOL.4.58.0312151949290.21523@green.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0312042225300.26114@yellow.csi.cam.ac.uk>
 <Pine.LNX.4.44.0312051109580.1782-100000@logos.cnet> <20031205113619.A20371@lists.us.dell.com>
 <1070901250.4508.1.camel@imp> <20031208222322.A21354@lists.us.dell.com>
 <1070987393.3447.64.camel@imp> <20031210144842.A24414@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Matt Domsch wrote:

> > The ds segment is not pointing to the correct segment AND/OR the offsets
> > into the segment used for the writes are bogus.  You write straight into
> > ds and ds:si referenced memory but you never setup ds in the first
> > place.  So the writes done by the EDD code corrupt the loaded compressed
> > kernel and the decompression fails.
>
> ds is set up already to point at the empty_zero_page, else none of
> what I'm doing is correct.  But, it is very likely that something else
> is using 0x228 in empty_zero_page but isn't marked as using it in
> Documentation/i386/zero-page.txt.
>
> You've been patient, and thorough.  As another test, could you change
> include/asm-i386/edd.h: DISK80_SIG_BUFFER from 0x228 to 0x2cc (the
> four bytes immediately before the e820 memory buffer), and see if that
> helps?  If so, I'll submit a patch to use that instead, and another
> that markes 0x228 as in use by something else.

Hi Matt,

sorry for the delay but I am now on holidays until January because of my
impending wedding and I won't be back at work, where the affected PC lives
until 5th or 6th January (whichever is the Monday).  I will try it then,
sorry to have to keep you waiting so long.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
