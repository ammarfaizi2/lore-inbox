Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWJFVbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWJFVbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWJFVbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:31:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10454 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751080AbWJFVbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:31:19 -0400
Date: Fri, 6 Oct 2006 23:31:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061006213107.GA29572@elf.ucw.cz>
References: <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org> <20061004195229.GA4459@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org> <20061004204718.GA4599@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041522190.3952@g5.osdl.org> <20061005002637.GA5145@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005002637.GA5145@bougret.hpl.hp.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The very fact that this turned into a discussion is a sign that the ABI 
> > breakage wasn't handled well enough. Usually, when we do something, nobody 
> > ever even notices.
> 
> 	There was the grand total of *ONE* user who was personally
> impacted by the userspace API change (the two other, one was hit by a
> bug, now fixed, one was hit because of kernel API change + external
> driver). And I immediately proposed to postpone the change to a later
> time.

The fact that all the wireless tools print...

Warning: Driver for device eth1 has been compiled with version 20
of Wireless Extension, while this program supports up to version 17.

...shows that wireless is not as backwards compatible as usual kernel
ABIs are. I'm afraid that wireless extensions can not be helped
(designed with back-compatibility at wrong place), but can we make
sure new netlink ABI does not have similar problems?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
