Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbTAZQM0>; Sun, 26 Jan 2003 11:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbTAZQM0>; Sun, 26 Jan 2003 11:12:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6562 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266955AbTAZQMZ>;
	Sun, 26 Jan 2003 11:12:25 -0500
Date: Sun, 26 Jan 2003 17:21:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Hahn <hahn@physics.mcmaster.ca>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ATA TCQ  problems in 2.5.59
Message-ID: <20030126162120.GO889@suse.de>
References: <200301261605.00539.roy@karlsbakk.net> <Pine.LNX.4.44.0301261116390.16853-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301261116390.16853-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26 2003, Mark Hahn wrote:
> > I'm trying to turn on TCQ on 2.5.59, but it doesn't seem be able to set it to 
> > anything but 0 and 1. This is with TCQ default 'off':
> > 
> > # cat /proc/ide/hda/settings | grep using_tcq
> > using_tcq               0               0               32              rw
> > # echo using_tcq:32 > /proc/ide/hda/settings
> > # cat /proc/ide/hda/settings | grep using_tcq
> > using_tcq               1               0               32              rw
> 
> but it's a flag, not a count.  use CONFIG_BLK_DEV_IDE_TCQ_DEPTH
> if you want something other than the default depth of 1.

It's a flag, correct. The default depth is 32 though, not 1. And with
newer hdparms you can use -Q to set/query the tag depth of the drive. Be
careful with that though, it's not too well tested. IDE TCQ in 2.5 needs
a bit of work, I hope to do so soonish...

-- 
Jens Axboe

