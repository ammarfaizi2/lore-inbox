Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUG3JCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUG3JCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 05:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267664AbUG3JCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 05:02:09 -0400
Received: from styx.suse.cz ([82.119.242.94]:32898 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S267657AbUG3JCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 05:02:04 -0400
Date: Fri, 30 Jul 2004 11:03:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Paul Jackson <pj@sgi.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-ID: <20040730090354.GA2012@ucw.cz>
References: <87llh3ihcn.fsf@ibmpc.myhome.or.jp> <20040728231548.4edebd5b.pj@sgi.com> <87oelzjhcx.fsf@ibmpc.myhome.or.jp> <20040729024931.4b4e78e6.pj@sgi.com> <20040729162423.7452e8f5.akpm@osdl.org> <20040729165152.492faced.pj@sgi.com> <87pt6e2sm3.fsf@devron.myhome.or.jp> <20040730002706.2330974d.pj@sgi.com> <20040730080757.GA1068@ucw.cz> <20040730084103.GA5261@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730084103.GA5261@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 10:41:03AM +0200, Andries Brouwer wrote:

> On Fri, Jul 30, 2004 at 10:07:57AM +0200, Vojtech Pavlik wrote:
> 
> > Let me summarize.
> > 
> > In the past, the kernel had various different values of NR_KEYS, in this
> > order: 128, 512, 256, 255.
> > 
> > 128 was not enough, 512 didn't fit in a byte (while allowed to address
> > all keycodes the input layer uses), 256 broke some apps that relied on
> > unsigned char counters,
> 
> Can you elaborate on this part? Which applications broke?

Hmm, so bk says it was the other way around:

128, 256, 512, 255

And 256 probably worked for most people, except loadkeys had to be
changed not to #define NR_KEYS itself. So now I believe that 256 could
actually be safe.

> Revert Andrew's patch: yes.
> Choosing 255/256 - I have no opinion yet, my opinion will depend
> on your answer to the above "Which applications broke?".

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
