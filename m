Return-Path: <linux-kernel-owner+w=401wt.eu-S1762454AbWLJT6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762454AbWLJT6c (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762457AbWLJT6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:58:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39465 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762452AbWLJT6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:58:31 -0500
Date: Sun, 10 Dec 2006 20:58:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Wouter Verhelst <wouter@grep.be>
Cc: Paul Clements <paul.clements@steeleye.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: show nbd client pid in sysfs
Message-ID: <20061210195819.GA32577@elf.ucw.cz>
References: <45762745.7010202@steeleye.com> <20061208211723.GC4924@ucw.cz> <20061210180725.GA29943@country.grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210180725.GA29943@country.grep.be>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This simple patch allows nbd to expose the nbd-client 
> > > daemon's PID in /sys/block/nbd<x>/pid. This is helpful 
> > > for tracking connection status of a device and for 
> > > determining which nbd devices are currently in use.
> > 
> > Actually is it needed at all? Perhaps nbd clients should be modified
> > to put nbdX in their process nam?
> 
> I don't think that's the right approach; only the kernel can guarantee
> that a given process is actually managing a given nbd device (I could
> have some rogue process running around announcing that it's managing
> nbd2, and then what?)

I'd say "do not run rogue processes as root" :-).

nbd-client should run as root -- I do not think interface was
carefully audited to run it as a user -- so rogue process should not
really be a problem.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
