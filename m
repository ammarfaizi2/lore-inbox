Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVGaNk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVGaNk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 09:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVGaNi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 09:38:57 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:16577 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261772AbVGaNi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 09:38:27 -0400
Date: Sun, 31 Jul 2005 08:37:37 -0500
From: serge@hallyn.com
To: Tony Jones <tonyj@immunix.com>
Cc: Steve Beattie <sbeattie@suse.de>, Tony Jones <tonyj@suse.de>,
       serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050731133737.GA19583@vino.hallyn.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050730050701.GA22901@immunix.com> <20050730190222.GA12473@vino.hallyn.com> <20050730201852.GA8223@immunix.com> <20050731032226.GC25629@immunix.com> <20050731034409.GA17120@vino.hallyn.com> <20050731041334.GA20780@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731041334.GA20780@immunix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Jones (tonyj@immunix.com):
> OK. As long as you are aware of it, which it sounds like you are.
> 
> Serge, I think it should be documented as a known issue.

Ok.

> > Clearly this is limiting, but then so is the one line per process you
> > get with ps - "fixing" that is obviously not acceptable.  Is there
> 
> Nothing jumps out at me.
> 
> > Is there any example where the current
> > behavior is actually a problem - two modules which it makes sense to
> > stack, which both need to give output under ps?
> 
> I don't know.  Isn't this the big negative against stacker, controlling
> the composition?  pstools has clearly cast it's vote :-)

Well, pstools combined with existing userspace tools.  I think the
older version of stacker outputed comma-delimited output for each
module.  But that requires changes in the selinux userspace tools for
things to work at all.  That doesn't mean it's not the better way to
solve the problem.  So for instance we could output

staff_u:staff_r:serge_t(selinux),jail3(bsdjail)

-serge
