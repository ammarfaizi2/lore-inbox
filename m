Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWE3VcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWE3VcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWE3VcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:32:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62060 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751506AbWE3VcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:32:05 -0400
Date: Tue, 30 May 2006 17:32:03 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
In-reply-to: <Pine.LNX.4.60.0605302301280.6213@poirot.grange>
X-X-Sender: nico@localhost.localdomain
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       lkml <linux-kernel@vger.kernel.org>, mattjreimer@gmail.com
Message-id: <Pine.LNX.4.64.0605301723060.16927@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <11371658562541-git-send-email-htejun@gmail.com>
 <1137167419.3365.5.camel@mulgrave>
 <20060113182035.GC25849@flint.arm.linux.org.uk>
 <1137177324.3365.67.camel@mulgrave>
 <20060113190613.GD25849@flint.arm.linux.org.uk>
 <20060222082732.GA24320@htj.dyndns.org>
 <1141325189.3238.37.camel@mulgrave.il.steeleye.com>
 <20060302203039.GH28895@flint.arm.linux.org.uk>
 <20060302204432.GZ4329@suse.de>
 <Pine.LNX.4.64.0605291509370.11290@localhost.localdomain>
 <447C2A48.1050200@gmail.com> <Pine.LNX.4.60.0605302301280.6213@poirot.grange>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006, Guennadi Liakhovetski wrote:

> On Tue, 30 May 2006, Tejun Heo wrote:
> 
> > Nicolas Pitre wrote:
> > > I do have hardware that exhibits the problem and therefore I wish the
> > > discussion could be resumed.
> 
> Partly to add myself to the cc-list, partly to add some oil in the fire - 
> there have been a few discussions on arm-kernel recently, one of them 
> 
> http://marc.theaimsgroup.com/?t=114136178100001&r=1&w=2
> 
> where at least you can get some more test results / failure pictures. 
> However, many have also stated that the patch set from Tejun, 
> unfortunately, doesn't fix 100% of IDE PIO cache coherency problems on 
> ARM.

The other problem is probably due to a mistake in the interpretation of 
some XScale document and if so is easily fixable (actually one bit 
difference in the page table).

The much more fundamental issue of having dirty lines after PIO in a 
VIVT cache that user space fails to see is a real and generic design 
issue on its own.


Nicolas
