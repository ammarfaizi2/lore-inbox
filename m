Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWJDWgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWJDWgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 18:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWJDWgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 18:36:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750770AbWJDWgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 18:36:32 -0400
Date: Wed, 4 Oct 2006 15:26:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <20061004204718.GA4599@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.64.0610041522190.3952@g5.osdl.org>
References: <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org>
 <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
 <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org>
 <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org>
 <20061004195229.GA4459@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org>
 <20061004204718.GA4599@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Oct 2006, Jean Tourrilhes wrote:
>
> 	Sometime breaking userspace APIs is perfectly OK, while
> sometimes it's not. You just have to make sure that Linus does not
> hear about it, I guess ;-)

I see the smiley, and I think you're trying to be funny and clever, but 
the thing is, I actually think that's _true_.

It's perfectly fine to break ABI's if nobody ever complains loudly enough 
that other developers notice.

So yes, we could actually even make it a real hard rule:

   "Breaking ABI's is fine. As long as you can hide the breakage so well 
    that nobody complains loudly enough that anybody ever notices".

The very fact that this turned into a discussion is a sign that the ABI 
breakage wasn't handled well enough. Usually, when we do something, nobody 
ever even notices.

(For an example of such a ABI breakage: I changed ptrace() to not allow 
ptracing another thread in the same thread group about a year ago, because 
it turned out that it was a serious local DoS problem. In the 12 months 
since, I think we had two people who ever actually noticed, and both of 
them actually caused some discussion about ways to perhaps unbreak it.)

			Linus
