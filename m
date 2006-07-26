Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWGZKIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWGZKIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWGZKIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:08:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35303 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751177AbWGZKIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:08:19 -0400
Date: Wed, 26 Jul 2006 12:08:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: swsusp status report
Message-ID: <20060726100807.GF1905@elf.ucw.cz>
References: <200607251325.14747.rjw@sisk.pl> <20060725151145.GG14964@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725151145.GG14964@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-07-25 11:11:45, Dave Jones wrote:
> On Tue, Jul 25, 2006 at 01:25:14PM +0200, Rafael J. Wysocki wrote:
> 
>  > V. Freeing memory
>  > 
>  > Step (3) of the suspend procedure is completed by calling the same
>  > functions that are normally used by kswapd, but in a slightly different way.
>  > The part of swsusp responsible for that is referred to as 'the memory
>  > shrinker' and it may sometimes be called by the suspend-to-RAM code as well
> 
> This isn't actually necessary though is it ?
> (Ie, it's a bug that needs fixing?)

Well, it is "nice" to the drivers to let them do their work with
reasonable ammount of memory free. Of course, it is also bug in the
driver if it fails to work in low-memory conditions. 

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
