Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTLQSd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTLQSd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:33:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43686 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264510AbTLQSdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:33:23 -0500
Date: Wed, 17 Dec 2003 19:33:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Thomas Voegtle <thomas@voegtle-clan.de>, linux-kernel@vger.kernel.org
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
Message-ID: <20031217183320.GD2495@suse.de>
References: <Pine.LNX.4.21.0312171721420.32339-100000@needs-no.brain.uni-freiburg.de> <200312171141.18132.gene.heskett@verizon.net> <20031217164933.GB2495@suse.de> <200312171227.53913.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312171227.53913.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17 2003, Gene Heskett wrote:
> On Wednesday 17 December 2003 11:49, Jens Axboe wrote:
> >On Wed, Dec 17 2003, Gene Heskett wrote:
> >> On Wednesday 17 December 2003 11:25, Thomas Voegtle wrote:
> >> >On Wed, 17 Dec 2003, Gene Heskett wrote:
> >> >> I take that it is attempting to scan all 8 addresses of the
> >> >> scsi bus even though its actually hitting the atapi stuff?  Or
> >> >> do I need an even fresher version of cdrecord? or libscg?
> >> >
> >> >Sorry, I shortend my output of cdrecord. With 2.6.0-test11 it
> >> > looks like this:
> >> >
> >> >Using libscg version 'schily-0.7'
> >> >scsibus0:
> >> >cdrecord: Warning: controller returns wrong size for CD
> >> > capabilities page. 0,0,0     0) 'CREATIVE' ' CD5233E        '
> >> > '2.05' Removable CD-ROM 0,1,0     1) 'PLEXTOR ' 'CD-R  
> >> > PX-W1610A' '1.04' Removable CD-ROM 0,2,0     2) *
> >> >        0,3,0     3) *
> >> >        0,4,0     4) *
> >> >        0,5,0     5) *
> >> >        0,6,0     6) *
> >> >        0,7,0     7) *
> >>
> >> I see.  I also don't see the warning you are getting, and this may
> >> be the reason you can't burn.  I also do not have the normal cdrom
> >> as device 0.  What happens if you swap the master/slave jumpers
> >> and put the recorder first?  It might be worth a try, and any
> >> changes in how it works would be a clue as to where the real
> >> stoppage is.
> >
> >The reason is that Thomas is using ATAPI which will go through
> >CDROM_SEND_PACKET (which is broken in -bk), while you are probably
> > not using that transport (and thus going to SG_IO directly, which
> > works).
> 
> I'm using /dev/hdc for burning in the k3b configuration screens, 
> however that path may actually be defined.  I haven't quite "grok"ed 
> all the details, but it works, and works with <10% of the cpu 
> involved when burning.
> 
> To me, thats a roaring success :-)

Excellent, glad to hear it :)

-- 
Jens Axboe

