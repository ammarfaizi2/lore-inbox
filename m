Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVADFmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVADFmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVADFmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:42:16 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:16141 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262045AbVADFmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 00:42:09 -0500
Date: Tue, 4 Jan 2005 06:33:48 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Thomas Graf <tgraf@suug.ch>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104053348.GB19945@alpha.home.local>
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> <20050103183621.GA2885@thunk.org> <20050103185927.C3442@flint.arm.linux.org.uk> <20050104002452.GA8045@thunk.org> <20050104031229.GE26856@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104031229.GE26856@postel.suug.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 04:12:29AM +0100, Thomas Graf wrote:
> * Theodore Ts'o <20050104002452.GA8045@thunk.org> 2005-01-03 19:24
> > On Mon, Jan 03, 2005 at 06:59:27PM +0000, Russell King wrote:
> > > It is also the model we used until OLS this year - there was a 2.6
> > > release about once a month prior to OLS.  Post OLS, it's now once
> > > every three months or there abouts, which, IMO is far too long.
> > 
> > I was thinking more about every week or two (ok, two releases in a day
> > like we used to do in the 2.3 days was probably too freequent :-), but
> > sure, even going to a once-a-month release cycle would be better than
> > the current 3 months between 2.6.x releases.
> 
> It definitely satifies many of the impatients but it doesn't solve the
> stability problem. Many bugs do not show up on developer machines until
> just right after the release (as you pointed out already). rc releases
> don't work out as expected due to various reasons, i think one of them
> is that rc releases don't get announced on the newstickers, extra work
> is required to patch the kernel etc.

The problem with -rc is that there are two types of people :
  - the optimists who think "good, it's already rc. I'll download it and
    run it as soon as it's released"
 - the pessimists who think "I killed my machine twice with rc, let's leave
   it to other brave testers".

These two problems are solvable with the same solution : no rc anymore.
I agree with Ted. A version every week or 2 weeks is good. People will
run random versions, some will report problems, others not. After that,
you know the differences between exact releases, you don't have to parse
28 MB changes. And you can also ask them to upgrade or downgrade and
quickly find where the bug entered.

Others will find stable versions they will want to stick to for some time,
which would also improve the bugs detection. At the time of 2.1, there were
many people using it because there were known stable versions (thanks to
Alan, btw). I remember having run an NFS server on 2.1.131-ac13 which was
fast an rock solid at this time.

Today's -rc system slows down testing. I also look at 2.4 : people only
test 2.4 when there is a new release. Between releases, very few people
such Adrian and a few others recompile a full kernel and report problems.
When you don't have much free time, you don't want to spend it testing
pre-releases which you think did not change from the previous one.

> What about doing a test release
> just before releasing the final version. I'm not talking about yet
> another 2 weeks period but rather just 2-3 days and at most 2 bk
> releases in between. Full tarball must be available to make it as
> easy as possible. I'm quite sure there are a lot of willing testers
> simply too lazy to take a shot at every single rc release. If things
> get really worse and huge fixes are required the final release could
> be defered in favour of another rc cycle.

if it's 2-3 days, it's reasonnable I think. It should let some people
report build problems just before the real one.

Regards,
Willy

