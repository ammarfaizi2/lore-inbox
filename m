Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTKLRcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 12:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTKLRcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 12:32:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54225 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262321AbTKLRcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 12:32:03 -0500
Date: Wed, 12 Nov 2003 18:32:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: ide cdrom sg like access / rpcmgr ?
Message-ID: <20031112173201.GP21141@suse.de>
References: <20031112143130.GL21141@suse.de> <Pine.LNX.4.44.0311120829060.3288-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311120829060.3288-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12 2003, Linus Torvalds wrote:
> 
> On Wed, 12 Nov 2003, Jens Axboe wrote:
> > 
> > To make the below work, all you probably need to do is change sgio() to
> > use CDROM_SEND_PACKET for instance. That'll work in 2.4 and 2.6. You
> > just need to fill a cdrom_generic_command and send it to the cdrom fd.
> 
> Don't forget: you also need to open the device with "O_NONBLOCK", so as to 
> not make the kernel try to figure out the media etc. Otherwise you can't 
> do anything with media that the kernel can't figure out (ie empty media 
> that hasn't been written to, or even no media at all).
> 
> Depending on what your tool is for, this may or may not be a problem, of 
> course. If you only want to send commands to a drive that already has a 
> readable media in it, you can skip the O_NONBLOCK.

Yes of course, you are absolutely right.

-- 
Jens Axboe

