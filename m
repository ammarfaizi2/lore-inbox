Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266664AbUBLWdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUBLWcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:32:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:27619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266650AbUBLWco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:32:44 -0500
Date: Thu, 12 Feb 2004 14:34:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Scott <nathans@sgi.com>
Cc: miquels@cistron.nl, linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: Re: 2.6.3-rc2-mm1 (dm)
Message-Id: <20040212143417.41d2ce58.akpm@osdl.org>
In-Reply-To: <20040212212811.GA655@frodo>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	<20040212203306.GA13192@cistron.nl>
	<20040212212811.GA655@frodo>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott <nathans@sgi.com> wrote:
>
> > This forces the underlying device(s) to a soft blocksize of 512. And
> > I had my 80 MB/sec write speed back !
> > 
> > I'm not sure if setting the blocksize of the underlying device
> > always to 512 is the right solution. I think that set_blocksize
> 
> Hmm... that set_blocksize there must be new in -mm, I don't see
> that in mainline yet.  I would guess that bdev_hardsect_size()
> would be more appropriate here than hard-coding 512 bytes.  I
> don't know the details of the problem being solving by adding
> set_blocksize() in there though, so I might be completely wrong.

Yes, 2.6.3-rc2-mm1 has a new device-mapper update.

Miquel, thanks for picking this up.  I shall wait for the LVM team to
suggest the preferred fix.

