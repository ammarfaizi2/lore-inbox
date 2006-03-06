Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWCFP72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWCFP72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWCFP72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:59:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3001 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751800AbWCFP71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:59:27 -0500
Date: Mon, 6 Mar 2006 10:59:20 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, greg@kroah.com, torvalds@osdl.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: oops in choose_configuration()
Message-ID: <20060306155920.GM21445@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
	greg@kroah.com, torvalds@osdl.org, mingo@elte.hu,
	linux-kernel@vger.kernel.org
References: <20060304121723.19fe9b4b.akpm@osdl.org> <Pine.LNX.4.64.0603041235110.22647@g5.osdl.org> <20060304213447.GA4445@kroah.com> <20060304135138.613021bd.akpm@osdl.org> <20060304221810.GA20011@kroah.com> <20060305154858.0fb0006a.akpm@osdl.org> <9a8748490603060304q2fa22a4fq6d4abf1a8e990482@mail.gmail.com> <20060306031550.15f76dc7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306031550.15f76dc7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 03:15:50AM -0800, Andrew Morton wrote:

 > Yes, there have been several memory-scribblish reports.  Until this one's
 > found I'm not sure there's much we can do with them.
 > 
 > I'll do an overnight run with CONFIG_DEBUG_SLAB, see if that catches
 > anything.  Although AFAICT it just fixes the bug.
 > 
 > Beyond that, I'm rather stuck.  I'd probably have to drop a pile of sched
 > patches, see if that improves things for people.  But if we cannot spot a
 > bug in those patches then it's probably in mainline and it will bite
 > people in generally random and rare ways.

Not sure if it was you or Linus I private-mailed about this, but
to reiterate - circa rc4-git2, the Fedora rawhide kernel stopped booting
for a bunch of people, all with 686-SMP boxes. I saw it myself too,
it hung just after the 'write protecting kernel rodata'.

It totally puzzled me for a day.  The following day, I rebased to rc4-git4,
and the problem "went away".  Nothing in the changesets merged could
explain the hangs I saw.

A few days ago, the exact same bug resurfaced, and like before, the
following day, it went into hiding again.

I'm terrified the release kernel I build for FC5 is going to be a
stinker because of this, but every time I tried to instrument this,
the bugger disappeared.

I'm not sure this is even remotely the same bug you're chasing,
but the unpredictability of really nasty bugs like these give
me the creeps.

		Dave

-- 
http://www.codemonkey.org.uk
