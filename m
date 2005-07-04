Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVGDHjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVGDHjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 03:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVGDHgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 03:36:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56805 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261413AbVGDH3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 03:29:19 -0400
Date: Mon, 4 Jul 2005 09:30:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050704073031.GI1444@suse.de>
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120462037.3174.25.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04 2005, Arjan van de Ven wrote:
> 
> > 
> > Yeah, that likely needs a little help from the ide driver. If you force
> > a spindown, you will effectively have parked the head for as long as the
> > spindown + spinup takes. That could turn out to be enough, it will take
> > more than 1-2 seconds anyways.
> 
> I doubt it; laptop disks seem to be optimized for spinning up/down fast
> (for powersaving reasons) so while for normal disks I'd agree with you,
> for laptop disks I'm far less sure.

It isn't too pretty to rely on such unreliable timing anyways. I'm not
too crazy about spinning the disk down either, it's useless wear
compared to just parking the head.

-- 
Jens Axboe

