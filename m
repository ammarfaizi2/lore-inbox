Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVGaESD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVGaESD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 00:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVGaESD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 00:18:03 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:41678 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S261591AbVGaESB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 00:18:01 -0400
Date: Sat, 30 Jul 2005 21:13:34 -0700
From: Tony Jones <tonyj@immunix.com>
To: serge@hallyn.com
Cc: Steve Beattie <sbeattie@suse.de>, Tony Jones <tonyj@suse.de>,
       serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050731041334.GA20780@immunix.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050730050701.GA22901@immunix.com> <20050730190222.GA12473@vino.hallyn.com> <20050730201852.GA8223@immunix.com> <20050731032226.GC25629@immunix.com> <20050731034409.GA17120@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731034409.GA17120@vino.hallyn.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 10:44:09PM -0500, serge@hallyn.com wrote:
> > When I discussed this with Albert Cahalan, he *strongly* objected to
> > allowing whitespace in security contexts, as he felt it would break
> > scripts that parsed 'ps -Z' output.
> 
> Right, I thought this was actually a feature :)  This is how ps
> continues to show expected output under stacker.  Given naturally limited
> space, showing output for multiple modules may not be a good idea.  If
> you want more detail, you go to /proc/pid/attr/current...

OK. As long as you are aware of it, which it sounds like you are.

Serge, I think it should be documented as a known issue.

> Clearly this is limiting, but then so is the one line per process you
> get with ps - "fixing" that is obviously not acceptable.  Is there

Nothing jumps out at me.

> Is there any example where the current
> behavior is actually a problem - two modules which it makes sense to
> stack, which both need to give output under ps?

I don't know.  Isn't this the big negative against stacker, controlling
the composition?  pstools has clearly cast it's vote :-)

Tony
