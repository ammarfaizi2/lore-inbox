Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUG3Ilh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUG3Ilh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 04:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265773AbUG3Ilh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 04:41:37 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:5391 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S267658AbUG3IlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 04:41:07 -0400
Date: Fri, 30 Jul 2004 10:41:03 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Paul Jackson <pj@sgi.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       akpm@osdl.org, aebr@win.tue.nl, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-ID: <20040730084103.GA5261@pclin040.win.tue.nl>
References: <20040728134202.5938b275.pj@sgi.com> <87llh3ihcn.fsf@ibmpc.myhome.or.jp> <20040728231548.4edebd5b.pj@sgi.com> <87oelzjhcx.fsf@ibmpc.myhome.or.jp> <20040729024931.4b4e78e6.pj@sgi.com> <20040729162423.7452e8f5.akpm@osdl.org> <20040729165152.492faced.pj@sgi.com> <87pt6e2sm3.fsf@devron.myhome.or.jp> <20040730002706.2330974d.pj@sgi.com> <20040730080757.GA1068@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730080757.GA1068@ucw.cz>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 10:07:57AM +0200, Vojtech Pavlik wrote:

> Let me summarize.
> 
> In the past, the kernel had various different values of NR_KEYS, in this
> order: 128, 512, 256, 255.
> 
> 128 was not enough, 512 didn't fit in a byte (while allowed to address
> all keycodes the input layer uses), 256 broke some apps that relied on
> unsigned char counters,

Can you elaborate on this part? Which applications broke?

> ...
> BUT some binaries are still compiled with 256 and try to set up a
> mapping for keycode 255 (although there is _no_ such keycode), and
> break. IMO it's a bug in the app.
> 
> Now I believe that simply adding the check back by reverting the old
> Andrew's patch and recompiling/fixing what breaks is the right way to
> go.

Revert Andrew's patch: yes.
Choosing 255/256 - I have no opinion yet, my opinion will depend
on your answer to the above "Which applications broke?".

Andries
