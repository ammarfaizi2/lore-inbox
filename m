Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWGWFlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWGWFlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 01:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWGWFlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 01:41:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750742AbWGWFlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 01:41:10 -0400
Date: Sat, 22 Jul 2006 22:34:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, ashok.raj@intel.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: remove cpu hotplug bustification in cpufreq.
Message-Id: <20060722223425.c94a858e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607221813020.29649@g5.osdl.org>
References: <20060722194018.GA28924@redhat.com>
	<Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
	<20060722180602.ac0d36f5.akpm@osdl.org>
	<Pine.LNX.4.64.0607221813020.29649@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006 18:15:32 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Sat, 22 Jul 2006, Andrew Morton wrote:
> > 
> > It was just wrong in conception.  We should not and probably cannot fix it.
> > Let's just delete it all, then implement version 2.
> 
> Well, I just got Ashok's trial patches which turns the thing into a rwsem 
> as I outlined earlier.

Mark my words ;)

> I'll try them out. If they don't work, we should just delete the lock and 
> go totally back to square 1.

rwsem conversion has the potential to merely hide the problem.  Ingo, does
lockdep detect recursive down_read()?
