Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965325AbWGJXcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965325AbWGJXcq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbWGJXcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:32:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17344 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965325AbWGJXco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:32:44 -0400
Date: Tue, 11 Jul 2006 00:36:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brad Campbell <brad@wasp.net.au>
Cc: suspend2-devel@lists.suspend2.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: /dev/rtc not suspending/resuming properly
Message-ID: <20060710223629.GA7443@elf.ucw.cz>
References: <44B24CEB.9010103@wasp.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B24CEB.9010103@wasp.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In trying to track down a bug in an application, I think I may have 
> stumbled across one in the kernel.

Well, that happens in suspend/resume area...

> It would appear that the rtc device is not restoring the state of the PIE 
> control bit when the machine goes to sleep and then wakes up again, 
> resulting in the rtc_dropped_irq() being called repeatedly until the 
> application accessing /dev/rtc is stopped.
> 
> I'm using a vanilla 2.6.17.3 kernel with the suspend2 patch only on x86
> 
> I've had a pretty good look at drivers/char/rtc.c and I can't see anywhere 
> it would actually suspend/resume in the code, and investigation shows it 
> does not appear to re-init the hardware on resume.

Well, you probably need to write suspend/resume support for it...

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
