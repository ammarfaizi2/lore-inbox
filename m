Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUIPEAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUIPEAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 00:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUIPEAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 00:00:00 -0400
Received: from holomorphy.com ([207.189.100.168]:17057 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267445AbUIPD76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 23:59:58 -0400
Date: Wed, 15 Sep 2004 20:59:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040916035952.GK9106@holomorphy.com>
References: <1095288600.1174.5968.camel@cube> <20040915231518.GB31909@devserv.devel.redhat.com> <20040915232956.GE9106@holomorphy.com> <1095300619.2191.6392.camel@cube> <20040916023604.GH9106@holomorphy.com> <1095306363.3874.101.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095306363.3874.101.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 22:36, William Lee Irwin III wrote:
>> Not over a call to schedule(). In the midst of schedule().

On Wed, Sep 15, 2004 at 11:49:38PM -0400, Albert Cahalan wrote:
> OK, let's look.
> First, there's fork/vfork/clone. At no point does
> "current" change. A process comes into existance
> with a ready-made current.
> Second, there's sched.c with context_switch().
> That does everything via switch_to, like so:
> /* Here we just switch the register state and the stack. */
> switch_to(prev, next, prev);
> No problem. Now I only need to show that switch_to()
> is safe. Unfortunately, it's arch-specific code.
> I'll look at a few examples...

gcc has to compile more than Linux. There has to be a rule for how this
works, not "gee, Linux will still work and get faster if we change this".


-- wli
