Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTIQKbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 06:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTIQKbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 06:31:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19588 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262675AbTIQKbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 06:31:32 -0400
Date: Wed, 17 Sep 2003 12:31:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030917103127.GM906@suse.de>
References: <20030910114346.025fdb59.akpm@osdl.org> <200309160134.28169.ianh@iahastie.local.net> <20030916092040.GB930@suse.de> <200309161926.04549.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309161926.04549.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16 2003, Ian Hastie wrote:
> On Tuesday 16 Sep 2003 10:20, Jens Axboe wrote:
> > On Tue, Sep 16 2003, Ian Hastie wrote:
> > > On Thursday 11 Sep 2003 22:52, Jens Axboe wrote:
> > > > Surely the pro version supports open-by-device as well? And then it
> > > > should work fine.
> > >
> > > It does.  However it also produces the same error message as cdrecord
> > > when doing so, ie
> > >
> > > Warning: Open by 'devname' is unintentional and not supported.
> > >
> > > The implication being that it could go away or become broken at any time.
> >
> > I wouldn't read anything in to that if I were you. Joerg has some mis
> > guided ideas about ATAPI addressing, but he would be a fool to remove
> > open by devname at this point.
> 
> What about this version of the argument then?  There are a number if
> pieces of software, eg cdrdao, that don't support open by devname.
> The kernel developers would be foolish to remove support for them at
> this time.  Works both ways doesn't it.

(cc me if you want me to read the mails, thanks)

That's a different discussion - they don't work with SG_IO typically
either, so they await the block sg driver anyways. It doesn't change the
fact that trying to pretend devices are hanging off a SCSI bus with bus
and device ids when they are not is just horrible.

-- 
Jens Axboe

