Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVEIKNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVEIKNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 06:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVEIKNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 06:13:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11739 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261209AbVEIKNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 06:13:47 -0400
Date: Mon, 9 May 2005 12:13:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Jon Escombe <trial@dresco.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Suspend/Resume
Message-ID: <20050509101344.GA24478@atrey.karlin.mff.cuni.cz>
References: <4267B5B0.8050608@davyandbeth.com> <loom.20050502T161322-252@post.gmane.org> <20050502144703.GA1882@suse.de> <loom.20050502T221228-244@post.gmane.org> <20050503141017.GD6115@suse.de> <1115524401.5942.13.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115524401.5942.13.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't know, depends on what Jeff/James think of this approach. There
> > are many different way to solve this problem. I let the scsi bus called
> > suspend/resume for the devices on that bus, and let the scsi host
> > adapter perform any device dependent actions. The pci helpers are less
> > debatable.
> > 
> > Jeff/James? Here's a patch that applies to current git.
> 
> The patch looks fine as far as it goes ... however, shouldn't we be
> spinning *internal* suspended drives down as well like IDE does (i.e. at
> least the sd ULD needs to be a party to the suspend)?  Of course this is

In IDE we do that to reliably flush drive caches... If write caching
actually works on SCSI, we should not need that hacks.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
