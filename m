Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWIVFXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWIVFXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWIVFXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:23:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3765 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932276AbWIVFXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:23:30 -0400
Date: Fri, 22 Sep 2006 07:23:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 0/6] swsusp: Add support for swap files
Message-ID: <20060922052324.GG2357@elf.ucw.cz>
References: <200609202120.58082.rjw@sisk.pl> <1158886913.15894.31.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158886913.15894.31.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-09-22 11:01:53, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2006-09-20 at 21:20 +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following series of patches makes swsusp support swap files.
> > 
> > For now, it is only possible to suspend to a swap file using the in-kernel
> > swsusp and the resume cannot be initiated from an initrd.
> 
> I'm trying to understand 'resume cannot be initiated from an initrd'.
> Does that mean if you want to use this functionality, you have to have
> everything needed compiled in to the kernel, and it's not compatible
> with LVM and so on?

Not in this version of patch; for resume from initrd, ioctl()
interface needs to be added (*).
									Pavel
(*) Actually.. of course resume from file from initrd is possible
*now*, probably without this patch series, but that would be bmap and
doing it by hand from userland.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
