Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTFIOUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTFIOUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:20:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27842 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264358AbTFIOUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:20:50 -0400
Date: Mon, 9 Jun 2003 15:34:23 +0100
From: Matthew Wilcox <willy@debian.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030609143423.GR28581@parcelfarce.linux.theplanet.co.uk>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk> <20030609140749.A15138@jurassic.park.msu.ru> <20030609111739.GP28581@parcelfarce.linux.theplanet.co.uk> <20030609152616.D15283@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609152616.D15283@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 03:26:16PM +0400, Ivan Kokshaysky wrote:
> On Mon, Jun 09, 2003 at 12:17:39PM +0100, Matthew Wilcox wrote:
> > hmm, yes, well.  There's a certain amount of sloppiness allowed with
> > it being a macro, in that bus->sysdata and dev->sysdata have the same
> > value so it works both ways.
> 
> Well, it's true for many architectures, but not for all.
> IIRC, bus->sysdata != dev->sysdata on sparc and parisc.

Certainly not true for parisc.  It might be true for sparc; I'm not quite
sure what arch/sparc/kernel/pcic.c is up to -- it seems a little bitrotten.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
