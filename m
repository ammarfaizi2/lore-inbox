Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263346AbVGAOHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbVGAOHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 10:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbVGAOHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 10:07:12 -0400
Received: from [212.76.81.133] ([212.76.81.133]:12550 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S263346AbVGAOHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 10:07:02 -0400
Message-Id: <200507011405.RAA27425@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Jens Axboe'" <axboe@suse.de>, "'David Masover'" <ninja@slaphack.com>
Cc: "'Chris Wedgwood'" <cw@f00f.org>, "'Nathan Scott'" <nathans@sgi.com>,
       <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: RE: XFS corruption during power-blackout
Date: Fri, 1 Jul 2005 17:05:11 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050701092412.GD2243@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV+HfWgqiiuY9vWQrSqU6po5PQNIgAJi6Lg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote: {
On Fri, Jul 01 2005, David Masover wrote:
> Chris Wedgwood wrote:
> >On Wed, Jun 29, 2005 at 07:53:09AM +0300, Al Boldi wrote:
> >
> >
> >>What I found were 4 things in the dest dir:
> >>1. Missing Dirs,Files. That's OK.
> >>2. Files of size 0. That's acceptable.
> >>3. Corrupted Files. That's unacceptable.
> >>4. Corrupted Files with original fingerprint. That's ABSOLUTELY 
> >>unacceptable.
> >
> >
> >disk usually default to caching these days and can lose data as a 
> >result, disable that
> 
> Not always possible.  Some disks lie and leave caching on anyway.

And the same (and others) disks will not honor a flush anyways. 
Moral of that story - avoid bad hardware.
}

1. Sync is not the issue. The issue is whether a journaled FS can detect
corrupted files and flag them after a power-blackout!
2. Moral of the story is: What's ext3 doing the others aren't?

