Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTJFTKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTJFTKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:10:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:5093 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262197AbTJFTKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:10:24 -0400
Date: Mon, 6 Oct 2003 12:10:04 -0700
From: Greg KH <greg@kroah.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006191004.GA12979@kroah.com>
References: <Dzxw.1wW.3@gated-at.bofh.it> <DGfG.4UY.3@gated-at.bofh.it> <DHv1.5Ir.1@gated-at.bofh.it> <DHEU.7ET.19@gated-at.bofh.it> <DHY6.3c0.7@gated-at.bofh.it> <DI7S.58w.13@gated-at.bofh.it> <E1A6ac0-0000rX-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A6ac0-0000rX-00@neptune.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 09:01:40PM +0200, Pascal Schmidt wrote:
> On Mon, 06 Oct 2003 20:20:16 +0200, you wrote in linux.kernel:
> 
> > Does that make more sense?  We can't just look at what happens with this
> > patch without actually accessing all of the sysfs tree, as that will be
> > the "normal" case.
> 
> Well, the normal case for me and other people not using any hot-pluggable
> devices will be to run a hotplug agent that does absolutely nothing... so
> in my case, the proposed patch would help - more memory available for the
> normal work I do.
> 
> With a static /dev and no hotpluggable stuff around, there is no need
> for and hotplug agent being there at all. And I do think such system
> are not too uncommon, so considering them would probably be nice.

Systems like this are not uncommon, I agree.  But also for systems like
this, the current code works just fine (small number of fixed devices.)
I haven't heard anyone complain about memory usage for a normal system
(99.9% of the systems out there.)

Also,  remember that in 2.7 I'm going to make device numbers random so
you will have to use something like udev to control your /dev tree.
Slowly weaning yourself off of a static /dev during the next 2 years or
so might be a good idea :)

thanks,

greg k-h
