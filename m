Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTEFS3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTEFS3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:29:53 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:21676
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S264023AbTEFS3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:29:53 -0400
Date: Tue, 6 May 2003 14:42:18 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Meissner <meissner@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
In-Reply-To: <20030506183010.GK905@suse.de>
Message-ID: <Pine.LNX.4.44.0305061436510.11648-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Jens Axboe wrote:

> On Tue, May 06 2003, Alan Cox wrote:
> > On Maw, 2003-05-06 at 18:23, Nicolas Pitre wrote:
> > > According to Alan it's nearly possible to configure the block layer out 
> > > entirely, which would be a good thing to associate with a CONFIG_DISK option 
> > > too.
> > 
> > David Woodhouse I believe..
> 
> Are we talking about everything below submit_bh/bio? Shouldn't be too
> hard to write a small no-block.c for that...

The idea is to configure out everything not needed when only NFS and/or JFFS 
(which doesn't rely on the block layer to work) are used.  Pretty useful for 
networked or embedded machines.


Nicolas

