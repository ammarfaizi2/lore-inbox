Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVEIOII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVEIOII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVEIOHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:07:53 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:13726 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261376AbVEIOHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:07:37 -0400
Subject: Re: Suspend/Resume
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, Jon Escombe <trial@dresco.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050509101344.GA24478@atrey.karlin.mff.cuni.cz>
References: <4267B5B0.8050608@davyandbeth.com>
	 <loom.20050502T161322-252@post.gmane.org> <20050502144703.GA1882@suse.de>
	 <loom.20050502T221228-244@post.gmane.org> <20050503141017.GD6115@suse.de>
	 <1115524401.5942.13.camel@mulgrave>
	 <20050509101344.GA24478@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Mon, 09 May 2005 09:07:21 -0500
Message-Id: <1115647641.5051.1.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 12:13 +0200, Pavel Machek wrote:
> In IDE we do that to reliably flush drive caches... If write caching
> actually works on SCSI, we should not need that hacks.

Define "works".  Actual write caching works fine with IDE (it doesn't
lose the data).  On the other hand, turning the cache off or flushing it
can be problematic because not all IDE devices respond to these
commands.

So, what I think you're saying is that you don't want the internal
drives to spin down, but you do want to send a synchronize cache command
to those which have a writeback cache enabled?

James


