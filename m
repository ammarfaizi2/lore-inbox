Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbTIIW7C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTIIW7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:59:01 -0400
Received: from gprs149-34.eurotel.cz ([160.218.149.34]:3456 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264843AbTIIW5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:57:04 -0400
Date: Wed, 10 Sep 2003 00:56:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jens Axboe <axboe@suse.de>, Patrick Mochel <mochel@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030909225650.GE211@elf.ucw.cz>
References: <20030823114738.B25729@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308250840360.1157-100000@cherise> <20030825172737.E16790@flint.arm.linux.org.uk> <20030901120208.GC1358@openzaurus.ucw.cz> <20030902174126.GB14209@suse.de> <1063138756.642.48.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063138756.642.48.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ide-cd should have a flush write cache as well, for mtr, dvd-ram, cd-rw
> > with packet writing, etc.
> 
> This is currently not done by the ide-cd suspend state machine, I did
> the infrastructure and ide-disk implementation, but I'm leaving things
> like ide-cd to you :)
> 
> Patrick: As we discussed on IRC, the actual PM state constants you
> defined don't match the old "S" levels, thus this code in ide-disk
> suspend notifier:
> 
>                 if (rq->pm->pm_state == 4)
>  
> to avoid stopping the platter on  suspend-to-disk will not work.
> 
> Should I fix the above to use a PM_* constant or will you fix the
> constants ?

Well, saying "4" is not enough, as you want to stop platter ... no in
this case it is enough. s4bios and swsusp behave the same here. [I
still think there may be cases where s4bios needs one behaviour and
swsusp needs another one.]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
