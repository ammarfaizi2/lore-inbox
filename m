Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWE3VHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWE3VHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWE3VHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:07:15 -0400
Received: from mail.gmx.de ([213.165.64.20]:43221 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932462AbWE3VHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:07:13 -0400
X-Authenticated: #20450766
Date: Tue, 30 May 2006 23:07:09 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Tejun Heo <htejun@gmail.com>
cc: Nicolas Pitre <nico@cam.org>, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       lkml <linux-kernel@vger.kernel.org>, mattjreimer@gmail.com
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
In-Reply-To: <447C2A48.1050200@gmail.com>
Message-ID: <Pine.LNX.4.60.0605302301280.6213@poirot.grange>
References: <11371658562541-git-send-email-htejun@gmail.com>
 <1137167419.3365.5.camel@mulgrave> <20060113182035.GC25849@flint.arm.linux.org.uk>
 <1137177324.3365.67.camel@mulgrave> <20060113190613.GD25849@flint.arm.linux.org.uk>
 <20060222082732.GA24320@htj.dyndns.org> <1141325189.3238.37.camel@mulgrave.il.steeleye.com>
 <20060302203039.GH28895@flint.arm.linux.org.uk> <20060302204432.GZ4329@suse.de>
 <Pine.LNX.4.64.0605291509370.11290@localhost.localdomain> <447C2A48.1050200@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006, Tejun Heo wrote:

> Nicolas Pitre wrote:
> > Has any discussion about this problem lead to some consensus?
> 
> Argghhh.. I completely forgot about this.
> 
> > > What do you think of the kmap_atomic_pio() (notoriously bad at names,
> > > but it should get the point across) and kunmap_atomic_pio(), the latter
> > > accepting a read/write flag to note if we wrote to a vm page?
> > > 
> > > This is basically Tejuns original patch set, just moving it out of the
> > > block layer so it's a generel exported property of the kmap api.
> > 
> > What was the problem with Tejun's patchset already to which RMK (and many
> > others) agreed?
> > 
> > I do have hardware that exhibits the problem and therefore I wish the
> > discussion could be resumed.

Partly to add myself to the cc-list, partly to add some oil in the fire - 
there have been a few discussions on arm-kernel recently, one of them 

http://marc.theaimsgroup.com/?t=114136178100001&r=1&w=2

where at least you can get some more test results / failure pictures. 
However, many have also stated that the patch set from Tejun, 
unfortunately, doesn't fix 100% of IDE PIO cache coherency problems on 
ARM.

Thanks for bringing this back up
Guennadi
---
Guennadi Liakhovetski
