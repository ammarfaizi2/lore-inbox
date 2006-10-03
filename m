Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030595AbWJCWHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbWJCWHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbWJCWHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:07:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9443 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030595AbWJCWHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:07:34 -0400
Date: Tue, 3 Oct 2006 14:59:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "John W. Linville" <linville@tuxdriver.com>
cc: Jeff Garzik <jeff@garzik.org>, jt@hpl.hp.com,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <20061003214038.GE23912@tuxdriver.com>
Message-ID: <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
 <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com>
 <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
 <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
 <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org>
 <20061003214038.GE23912@tuxdriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Oct 2006, John W. Linville wrote:
>
> I.E.  With "WE-21 aware" tools already in the wild, it isn't now clear
> to me how WE can evolve any further than WE-20.

Well, if you get a WE-22 out soon enough, the situation will be one where 
people who are fast at updating will have a fixed version quickly, and the 
ones that aren't quick at updating will never have even seen the broken 
case.

And without any actual release kernel actually having had the issue, we 
should be pretty well off - the only people who actually saw semantics 
change were people who build their own kernels etc, and those people 
aren't the problem cases.

The users that you need to care about are the ones that upgrade rather 
seldom and/or need to maintain a stable setup for other reasons (eg it's 
not at all unheard of to have a common base release, but then have certain 
machines on the network with more modern kernels because they have new 
hardware that requires a modern kernel for support, for example: that's 
the situation where you may want to have a much older common user space, 
even if you have a new kernel).

Kernel developers tend to be happy to upgrade their user programs, and 
don't generally see it as a big problem. The people for whom it is a 
problem are elsewhere :)

		Linus
