Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbTEGPS4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTEGPS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:18:56 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:64664 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264044AbTEGPSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:18:54 -0400
Date: Wed, 7 May 2003 17:28:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030507152856.GF412@elf.ucw.cz>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507135600.A22642@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Only change *needed* in each architecture is moving A() macros into
> > > > compat.h, so that generic code can use it. Please apply,
> > > 
> > > Please don't use A() in new code, we now have compat_ptr() and
> > > compat_uptr_t for this.
> > 
> > Fixed now.
> 
> Btw, if you really want to move all the 32bit ioctl compat code to the
> drivers a ->ioctl32 file operation might be the better choice..

Not sure if we are not too close to stable release to do that? And I
see no incremental way how to get there. Moving compatibility stuff
closer to drivers can be done close to stable release...

OTOH it forces pain where it belongs, and when someone invents stupid
ioctl, it puts pain on him... I like that.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
