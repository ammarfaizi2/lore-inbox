Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946040AbWJaV3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946040AbWJaV3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946030AbWJaV3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:29:16 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:5093 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1946041AbWJaV3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:29:15 -0500
Date: Tue, 31 Oct 2006 21:29:03 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: ray-gmail@madrabbit.org, "Martin J. Bligh" <mbligh@google.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
Message-ID: <20061031212903.GQ29920@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com> <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com> <200610312053.k9VKr0Fm007201@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610312053.k9VKr0Fm007201@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 03:53:00PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 31 Oct 2006 08:34:23 PST, Ray Lee said:
> > On 10/31/06, Martin J. Bligh <mbligh@google.com> wrote:
> > > > At some point we should get rid of all the "politeness" warnings, just
> > > > because they can end up hiding the _real_ ones.
> > >
> > > Yay! Couldn't agree more. Does this mean you'll take patches for all the
> > > uninitialized variable crap from gcc 4.x ?
> > 
> > What would be useful in the short term is a tool that shows only the
> > new warnings that didn't exist in the last point release.
> 
> Harder to do than you might think - it has to deal with the fact that
> 2.6.N might have a warning about 'used unintialized on line 430', and
> in 2.6.N+1 you get two warnings, one on line 420 and one on 440.  Which
> one is new and which one just moved 10 lines up or down?  Or did a patch
> fix the one on 430 and add 2 new ones?

So you take the old log and replace the line numbers with those of
corresponding lines in new tree.  Marking ones that do not survive
unchanged with recognisable prefix.  _Then_ you diff logs.

In reality (and I'd been doing that for ranges like 2.6.14 -> 2.6.19-rc1)
you get very little noise.

Again, see remapper mentioned in this thread; it really works.
