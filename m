Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWHGXml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWHGXml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWHGXml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:42:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932419AbWHGXmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:42:40 -0400
Date: Mon, 7 Aug 2006 16:42:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Nate Diller" <nate.diller@gmail.com>
Cc: "Jens Axboe" <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] [1/3] add elv_extended_request call to iosched API
Message-Id: <20060807164230.03ed89a7.akpm@osdl.org>
In-Reply-To: <5c49b0ed0608071614k3a62a982jbe27fa0c6d5fdb0@mail.gmail.com>
References: <5c49b0ed0608031911id21b112t7f0c350a7f10a99@mail.gmail.com>
	<20060804052031.GA4717@suse.de>
	<20060803224519.dd9bf38e.akpm@osdl.org>
	<20060804133938.GX20624@suse.de>
	<5c49b0ed0608071614k3a62a982jbe27fa0c6d5fdb0@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 16:14:59 -0700
"Nate Diller" <nate.diller@gmail.com> wrote:

> On 8/4/06, Jens Axboe <axboe@suse.de> wrote:
> > On Thu, Aug 03 2006, Andrew Morton wrote:
> > > On Fri, 4 Aug 2006 07:20:32 +0200
> > > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > > On Thu, Aug 03 2006, Nate Diller wrote:
> > > > > the Elevator iosched would prefer to be unconditionally notified of a
> > > > > merge, but the current API calls only one 'merge' notifier
> > > > > (elv_merge_requests or elv_merged_requests), even if both front and
> > > > > back merges happened.
> > > > >
> > > > > elv_extended_request satisfies this requirement in conjunction with
> > > > > elv_merge_requests.
> > > >
> > > > Ok, I suppose. But please rebase patches against the 'block' git branch,
> > > > there are extensive changes in this area.
> > > >
> > >
> > > argh, the great (but partial ;)) renaming bites again.
> > >
> > > A suitable patch to merge against is
> > > http://www.zip.com.au/~akpm/linux/patches/stuff/git-block.patch
> >
> > not so much the renaming (that's easy enough), but the elevator core
> > parts changed in some areas.
> 
> would it be appropriate to submit against 2.6.18-rc3-mm2?

Yes, that should give us a patch which Jens can use.

Be aware that I've just gone and dropped git-block.patch due to
suspend/resume problems.  I expect it'll come back within a suitable
timeframe for you, but if it doesn't, inclusion in -mm might be delayed.

