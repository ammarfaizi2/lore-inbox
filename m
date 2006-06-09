Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030540AbWFIV4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540AbWFIV4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWFIV4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:56:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19165 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030540AbWFIV4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:56:13 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <4489ECDD.9060307@garzik.org>
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org>
	 <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org>
	 <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net>
	 <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org>
	 <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org>
	 <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk>
	 <4489ECDD.9060307@garzik.org>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 22:55:38 +0100
Message-Id: <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-06-09 at 17:49 -0400, Jeff Garzik wrote:

> >> Consider a blkdev of size S1.  Using LVM we increase that value under 
> >> the hood to size S2, where S2 > S1.  We perform an online resize from 
> >> size S1 to S2.  The size and alignment of any new groups added will 
> >> different from the non-resize case, where mke2fs was run directly on a 
> >> blkdev of size S2.
> > 
> > No, they won't.  We simply grow the last block group in the filesystem
> > up to the size where we'd naturally add another block group anyway; and
> > then, we add another block group exactly where it would have been on a
> > fresh mkfs.
> 
> Yes but the inodes per group etc. would differ.

No, we add the same number of inodes in the new groups that all the
previous groups have.

--Stephen


