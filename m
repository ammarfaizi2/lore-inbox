Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030634AbWJCWli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030634AbWJCWli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030635AbWJCWli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:41:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:19334 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030634AbWJCWlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:41:37 -0400
Message-ID: <4522E712.8020201@garzik.org>
Date: Tue, 03 Oct 2006 18:41:22 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
References: <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <4522DA9B.6050207@garzik.org> <20061003222707.GB1790@bougret.hpl.hp.com>
In-Reply-To: <20061003222707.GB1790@bougret.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	Let's not make a mountain of this molehill. If you want to use
> old versions of Wireless Tools and wpa_supplicant with WE-21, what you
> need is just to add a dummy character at the end of your ESSID. And
> everything will be fine.

FALSE.  Old apps are by definition already in place.  "all you need to 
do..." is an impossible condition to satisfy.


> 	Also, there is no other way to update cleanly a kernel API
> than to push userspace first. I think I took way more care in term of
> smoothing over the API transition than any other kernel subsystem, so
> I don't know what could have been done better. I don't remember this
> level of flamewar when those other subsystems did change their
> userspace APIs.

Userspace APIs can change, as long as they remain backwards compatible.

Just follow LKML to see all the flack people get, when userspace APIs 
change in an incompatible way.  Or heck, just look at the changelog for 
the patches we revert, when such brokenness is detected.

Finally, until an API is actually in a kernel release, it has the 
potential to change.  That's just a fact of Linux development.  I 
certainly understand trying to get stuff out ahead of a kernel release, 
but you must understand the negative consequences of doing so, when 
something goes wrong.  Like it did here.

	Jeff


