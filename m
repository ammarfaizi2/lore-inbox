Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTAKBjH>; Fri, 10 Jan 2003 20:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbTAKBjH>; Fri, 10 Jan 2003 20:39:07 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:46801 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266994AbTAKBjG>;
	Fri, 10 Jan 2003 20:39:06 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15903.30632.576801.904652@napali.hpl.hp.com>
Date: Fri, 10 Jan 2003 17:47:20 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, Mike Stephens <mike.stephens@intel.com>,
       linux-kernel@vger.kernel.org, bjornw@axis.com, geert@linux-m68k.org,
       ralf@gnu.org, mkp@mkp.net, willy@debian.org, anton@samba.org,
       gniibe@m17n.org, kkojima@rr.iij4u.or.jp, Jeff Dike <jdike@karaya.com>
Subject: Re: Userspace Test Framework for module loader porting 
In-Reply-To: <20030110073328.C96122C2A8@lists.samba.org>
References: <15898.8498.519625.200668@napali.hpl.hp.com>
	<20030110073328.C96122C2A8@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 08 Jan 2003 22:44:15 +1100, Rusty Russell <rusty@rustcorp.com.au> said:

  >> I'd rather prefer the old (user-level loader)
  >> or the new shared-object loader.

  Rusty> Really?  Because it already exists (and is maintained by
  Rusty> someone else) or for some other reason?

Yeah, I'm lazy: I don't really want to have to deal with two new
module loaders: one for 2.6, soon to be followed by one for 2.7.  But
if someone volunteers to do and _maintain_ an interim kernel loader,
that's fine with me.

  Rusty> I thought about letting archs choose which one they wanted to
  Rusty> use, but it would really mess up the core code.  Of course,
  Rusty> the transition won't break userspace (kind of the whole point
  Rusty> of the in-kernel module loader).

But it would be more in keeping with the Linux philosophy: do the
Right Thing, fix up "broken" stuff by doing whatever is necessary.
I'm also a bit worried about changing module loaders so often.  Yeah,
once you switch to a kernel-loader, presumably users won't be
affected, but (kernel-module) developers will be.

	--david
