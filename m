Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVGFFyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVGFFyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVGFFxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:53:48 -0400
Received: from [213.184.187.7] ([213.184.187.7]:44292 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261730AbVGFEZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 00:25:27 -0400
Message-Id: <200507060424.HAA27591@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Sonny Rao'" <sonny@burdell.org>
Cc: "'Jens Axboe'" <axboe@suse.de>, "'David Masover'" <ninja@slaphack.com>,
       "'Chris Wedgwood'" <cw@f00f.org>, "'Nathan Scott'" <nathans@sgi.com>,
       <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: RE: XFS corruption during power-blackout
Date: Wed, 6 Jul 2005 07:24:03 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20050705181057.GA16422@kevlar.burdell.org>
Thread-Index: AcWBjLAcL2Ef45tFSJOcSXMRBNyXrwAVUTmQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote: {
> > > >On Wed, Jun 29, 2005 at 07:53:09AM +0300, Al Boldi wrote:
> > > >>What I found were 4 things in the dest dir:
> > > >>1. Missing Dirs,Files. That's OK.
> > > >>2. Files of size 0. That's acceptable.
> > > >>3. Corrupted Files. That's unacceptable.
> > > >>4. Corrupted Files with original fingerprint. That's ABSOLUTELY 
> > > >>unacceptable.
> > > >
> > 2. Moral of the story is: What's ext3 doing the others aren't?
> 
> Ext3 has stronger guaranties than basic filesystem consistency.
> I.e. in ordered mode, file data is always written before metadata, so 
> the worst that could happen is a growing file's new data is written 
> but the metadata isn't updated before a power failure... so the new 
> writes wouldn't be seen afterwards.
> 
I believe in newer 2.6 kernels that Reiser has ordered mode (IIRC, courtesy
of Chris Mason), but XFS and JFS do not support it.
}

Was ordered mode disabled/removed when XFS was add to the vanilla-kernel?


