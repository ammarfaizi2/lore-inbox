Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270980AbTGPRDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270974AbTGPRCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:02:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50110 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270952AbTGPRBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:01:19 -0400
Date: Wed, 16 Jul 2003 19:16:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>, vojtech@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716171607.GM833@suse.de>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16 2003, Alan Cox wrote:
> On Mer, 2003-07-16 at 18:03, Jens Axboe wrote:
> > > The IDE CD drive is using DMA, and interrupts are unmasked.
> > > according to the logs, its happened 32 times since I last
> 
> > Yes. You can try and make the situation a little better by unmasking
> > interrupts with -u1. Or you can try and use a ripper that actually uses
> 
> He already is 

Yeah I noticed know :)

> > SG_IO, that way you can use dma (and zero copy) for the rips. That will
> > be lots more smooth.
> 
> So why isnt this occuring on 2.4 .. thats the important question here is
> this a logging thing, a new input layer bug, an ide bug or what ?

Dave, have you tried 2.4 newest? Some of the newer IDE stuff kept
interrupts off for ages, maybe it's on 2.4 also. Also Dave, can you try
and do a vmstat 1 while ripping and PS2 dropping out?

-- 
Jens Axboe

