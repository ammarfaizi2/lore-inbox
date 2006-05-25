Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbWEYWIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbWEYWIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWEYWIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:08:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45231 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030465AbWEYWIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:08:23 -0400
Date: Fri, 26 May 2006 00:07:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: swsusp in 2.6.16: works fine w/o PSE on a VIA C3?
Message-ID: <20060525220729.GA15063@elf.ucw.cz>
References: <4474D9EF.8030504@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4474D9EF.8030504@tls.msk.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 25-05-06 02:10:55, Michael Tokarev wrote:
> I was just feeling lucky and tried suspend-to-disk cycle
> on my VIA C3 machine, which lacks PSE which is marked as
> being required for swsusp to work.  After commenting out
> the PSE check in include/asm-i386/suspend.h and rebooting,
> I tried the whole cycle, several times, with real load
> (while running 3 kernel compile in parallel) and while
> IDLE... And surprizingly, it all worked flawlessly for
> me, without a single glitch...
> 
> So the question is: is PSE really needed nowadays?

I think so. If page directories are in "right" order in memory, it is
possible it works without PSE...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
