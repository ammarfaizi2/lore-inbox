Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTLIAoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTLIAoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:44:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:10675 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262116AbTLIAoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:44:09 -0500
Date: Mon, 8 Dec 2003 16:42:25 -0800
From: Greg KH <greg@kroah.com>
To: Sven-Haegar Koch <haegar@sdinet.de>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031209004225.GA31760@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <Pine.LNX.4.58.0312090128130.11775@mercury.sdinet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312090128130.11775@mercury.sdinet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 01:31:00AM +0100, Sven-Haegar Koch wrote:
> On Mon, 8 Dec 2003, Greg KH wrote:
> 
> > > After ignoring .devfsd we are left with 70 devices missing:
> > >  - 15 floppy devices
> >
> > You have 15 floppy devices connected to your box?  All floppy devices
> > should show up in /sys/block.
> 
> perhaps he means fd0u1440, fd0u1600 and friends
> 
> ls /dev/fd0u*|wc -l  -> 15

Yeah, but are those devices actually connected all at once?  Yeah, I
know the way of talking to the same device in different manners...

Hm, udev can now do symlinks, does it also need to handle multiple
minors for floppy devices?  I'll have to look into how the kernel
handles the different block minors for floppy devices.

thanks,

greg k-h
