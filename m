Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263064AbTCWN72>; Sun, 23 Mar 2003 08:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263065AbTCWN71>; Sun, 23 Mar 2003 08:59:27 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9634
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263064AbTCWN71>; Sun, 23 Mar 2003 08:59:27 -0500
Subject: Re: IDE todo list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030323104916.GI837@suse.de>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
	 <20030323104916.GI837@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048432981.10727.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 15:23:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 10:49, Jens Axboe wrote:
> On Sat, Mar 22 2003, Alan Cox wrote:
> > -	Finish verifying 256 sector I/O or larger on LBA48
> > 	[How to handle change dynamically on hotplug ?]
> 
> That is basically impossible. How are you going to handle the case where
> you have a queue full of 256 request writes, and the plugged in disk
> chokes on them? And insolvable unless you start setting aside requests
> simply for this purpose. Also breaks the pseudo atomic segments that a
> single request represents. This is just way beyond ugly...

I don't think its impossible at all. Remember if you hotplug a drive you
*dont* want the pending I/O to hit the new drive!

Alan


