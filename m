Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbULQT3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbULQT3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbULQT32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:29:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33944 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262135AbULQT2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:28:05 -0500
Date: Fri, 17 Dec 2004 20:27:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Kronos <kronos@kronoz.cjb.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rashkae <rashkae@tigershaunt.com>
Subject: Re: Cannot mount multi-session DVD with ide-cd, must use ide-scsi
Message-ID: <20041217192738.GJ3140@suse.de>
References: <20041217120854.GC3140@suse.de> <20041217183303.GA9561@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217183303.GA9561@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17 2004, Kronos wrote:
> Jens Axboe <axboe@suse.de> ha scritto:
> > On Fri, Dec 17 2004, Andrew Morton wrote:
> >> Rashkae <rashkae@tigershaunt.com> wrote:
> >> >
> >> > I can confirm that Linux Kerenl 2.6.9 still cannot mount a
> >> >  multi-session DVD if the last session starts at > 2.2 GB.  The
> >> >  only information on this problem I can find is here:
> >> > 
> >> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=108827602322464&w=2
> >> > 
> >> >  Is there a patch anywhere to address this?
> >> 
> >> Please test this.  Jens, could you please check this one?
> > 
> > It looks fine for the case where the tocentry read suceeds, but you
> > should change the fallback assignment to be lba based as well I think.
> 
> Ok, changed that part. I also changed the part inside the #if
> !STANDARD_ATAPI to re-read using MSF, just to be sure to not break
> anything. Maybe those two weird units (Vertos 300 and NEC 260) return
> the LBA value in a sane way and the whole #if block can be removed? 

Much better, Andrew will you pick this up?

-- 
Jens Axboe

