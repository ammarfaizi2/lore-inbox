Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbWJCWbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbWJCWbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbWJCWbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:31:43 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:27094 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1030621AbWJCWbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:31:42 -0400
Date: Tue, 3 Oct 2006 15:27:07 -0700
To: Jeff Garzik <jeff@garzik.org>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003222707.GB1790@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <4522DA9B.6050207@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522DA9B.6050207@garzik.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 05:48:11PM -0400, Jeff Garzik wrote:
> John W. Linville wrote:
> >Unfortunately, I don't see any way to "fix" WE-21 without similarly
> >breaking wireless-tools 29 and other "WE-21 aware" apps.  And since
> >I'll bet that the various WE-aware apps have checks like "if WE >
> >20" for managing ESSID length settings, we may have painted ourselves
> >into a korner (sic).
> 
> The apps are based on a pre-release kernel, which everyone knows could 
> change, precisely for reasons like this.  Sounds like somebody took a 
> risk, and lost...
> 
> 	Jeff

	Jeff,

	Let's not make a mountain of this molehill. If you want to use
old versions of Wireless Tools and wpa_supplicant with WE-21, what you
need is just to add a dummy character at the end of your ESSID. And
everything will be fine.

	Also, there is no other way to update cleanly a kernel API
than to push userspace first. I think I took way more care in term of
smoothing over the API transition than any other kernel subsystem, so
I don't know what could have been done better. I don't remember this
level of flamewar when those other subsystems did change their
userspace APIs.
	I try to be constructive about all this, so let's find a way
forward without loosing perspective.

	Regards,

	Jean
