Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263065AbTCWOCb>; Sun, 23 Mar 2003 09:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbTCWOCa>; Sun, 23 Mar 2003 09:02:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41391 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263065AbTCWOCa>;
	Sun, 23 Mar 2003 09:02:30 -0500
Date: Sun, 23 Mar 2003 15:13:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE todo list
Message-ID: <20030323141329.GD2371@suse.de>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk> <20030323104916.GI837@suse.de> <1048432981.10727.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048432981.10727.14.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23 2003, Alan Cox wrote:
> On Sun, 2003-03-23 at 10:49, Jens Axboe wrote:
> > On Sat, Mar 22 2003, Alan Cox wrote:
> > > -	Finish verifying 256 sector I/O or larger on LBA48
> > > 	[How to handle change dynamically on hotplug ?]
> > 
> > That is basically impossible. How are you going to handle the case where
> > you have a queue full of 256 request writes, and the plugged in disk
> > chokes on them? And insolvable unless you start setting aside requests
> > simply for this purpose. Also breaks the pseudo atomic segments that a
> > single request represents. This is just way beyond ugly...
> 
> I don't think its impossible at all. Remember if you hotplug a drive you
> *dont* want the pending I/O to hit the new drive!

In that case it could be done, the key point is that no resizing needs
to be done. The rest is purely driver implementation :)

-- 
Jens Axboe

