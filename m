Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWIVOSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWIVOSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWIVOSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:18:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932522AbWIVOSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:18:21 -0400
Date: Fri, 22 Sep 2006 16:18:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jason Lunz <lunz@falooley.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Message-ID: <20060922141817.GN3478@elf.ucw.cz>
References: <20060921235340.DBD89822B@knob.reflex> <20060921235817.GA27170@knob.reflex> <200609221257.12303.rjw@sisk.pl> <20060922141346.GA28949@opus.vpn-dev.reflex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922141346.GA28949@opus.vpn-dev.reflex>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-09-22 10:13:47, Jason Lunz wrote:
> On Fri, Sep 22, 2006 at 12:57:11PM +0200, Rafael J. Wysocki wrote:
> > This is filesystem-dependent.  AFAICT not all filesystems are supported
> > by GRUB.
> 
> of course, but it shows the technique is viable. Grub is 
> widespread, and if it's good enough for so many x86 users to boot with
> then the same approach ought to be adequate for resume, no?

Well, most people "solve" this by having their boot partition on ext2,
no?

Anyway, yes, you can do libext2 magic... in uswsusp..

Or you can just patch "real_read_only" mode to journalling
filesystem. That should be easy enough, and that patch would be
welcome for other reasons (data recovery), too. Please do it :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
