Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUERAup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUERAup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 20:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUERAup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 20:50:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261779AbUERAun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 20:50:43 -0400
Date: Tue, 18 May 2004 01:50:42 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver in 2.6.6 has a severe bug
Message-ID: <20040518005042.GW17014@parcelfarce.linux.theplanet.co.uk>
References: <20040517161943.37d826a3.akpm@osdl.org> <Pine.LNX.4.44.0405180132240.21480-100000@hubble.stokkie.net> <20040517170433.0311c2e9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517170433.0311c2e9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 05:04:33PM -0700, Andrew Morton wrote:
> "Robert M. Stockmann" <stock@stokkie.net> wrote:
> >
> > Be aware of other problems when using the linux ramdisk driver,
> > loosing its contents. Especially the use of mkinitrd might result in 
> > unexpected problems. googling for "kernel 2.6.6 ramdisk problem" shows lots
> > of people with problems mounting their root filesystems and loading modules
> > from ramdisk. Klaus Knopper (knoppix) is not amused, neither am i :)
> 
> Well in that case perhaps something else broke.  I've seen no such reports
> of recent regressions in the ramdisk driver.
> 
> The two problems of which I am aware are:
> 
> a) It loses its brains across umount.  Seems that it's very rare that
>    anyone actually cares about this, which is why it has not been fixed in
>    well over a year.

Details, please.  The only case I'm aware of is when you have fs-set
block size different from the one we had before mount(2).  And in that
case it would lose its brains when the blocksize had been flipped in
the first place.  Which would tend to fail mount(2) anyway.
