Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVEITRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVEITRx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVEITRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:17:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1409 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261478AbVEITRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:17:37 -0400
Date: Mon, 9 May 2005 21:17:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Jon Escombe <trial@dresco.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Suspend/Resume
Message-ID: <20050509191722.GB3085@elf.ucw.cz>
References: <4267B5B0.8050608@davyandbeth.com> <loom.20050502T161322-252@post.gmane.org> <20050502144703.GA1882@suse.de> <loom.20050502T221228-244@post.gmane.org> <20050503141017.GD6115@suse.de> <1115524401.5942.13.camel@mulgrave> <20050509101344.GA24478@atrey.karlin.mff.cuni.cz> <1115647641.5051.1.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115647641.5051.1.camel@mulgrave>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 09-05-05 09:07:21, James Bottomley wrote:
> On Mon, 2005-05-09 at 12:13 +0200, Pavel Machek wrote:
> > In IDE we do that to reliably flush drive caches... If write caching
> > actually works on SCSI, we should not need that hacks.
> 
> Define "works".  Actual write caching works fine with IDE (it doesn't
> lose the data).  On the other hand, turning the cache off or flushing it
> can be problematic because not all IDE devices respond to these
> commands.
> 
> So, what I think you're saying is that you don't want the internal
> drives to spin down, but you do want to send a synchronize cache command
> to those which have a writeback cache enabled?

Yes, something like that. I don't care if drivers are spinning or not,
but I need caches to be properly flushed and drive ready for system
powerdown.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
