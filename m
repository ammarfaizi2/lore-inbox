Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWITNHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWITNHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWITNHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:07:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8391 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751234AbWITNHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:07:36 -0400
Date: Wed, 20 Sep 2006 14:00:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth oops during resume from ram
Message-ID: <20060920120017.GA10792@elf.ucw.cz>
References: <20060917140952.GA3349@elf.ucw.cz> <1158511979.24941.1.camel@localhost> <20060917193659.GB2973@elf.ucw.cz> <1158560411.30486.20.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158560411.30486.20.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > not that I am aware of. Is this a plain 2.6.18-rc6 or did you apply
> > > additional patches that might have caused this behavior?
> > 
> > I have some additional changes, but they should not affect this...
> > 
> > OTOH, I probably used this script:
> > 
> > 
> > killall hciattach
> > sleep .1
> > setserial /dev/ttyBT baud_base 921600
> 
> whatever that is for. I thought the ttyBT was iPAQ specific or something
> like that.

It is symlink to ttyS0 on my machine.

> > hciattach -s 921600 /dev/ttyS0 bcsp
> 
> This is non-sense for a X60.

Yep... and this non-sense probably triggers oops during resume on
X60... so this is not critical. I'll investigate it a bit more.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
