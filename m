Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbSJMTdA>; Sun, 13 Oct 2002 15:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbSJMTdA>; Sun, 13 Oct 2002 15:33:00 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:20238 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261638AbSJMTc7>; Sun, 13 Oct 2002 15:32:59 -0400
Date: Sun, 13 Oct 2002 20:38:38 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, drepper@redhat.com, oprofile-list@lists.sf.net
Subject: [PATCH] oprofile for 2.5.42
Message-ID: <20021013193838.GA95824@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *180oZT-000CCd-00*Lk7soabObYs* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://oprofile.sourceforge.net/oprofile-2.5.html

as usual. This release has two significant changes :

o We got the task release stuff horribly wrong for CLONE_DETACHED tasks
as used by nptl, leading to instant oopsen. I think I have fixed this.
One drawback is that the do_exit()-related code is now an oprofile blind
spot, but I can't see a better solution

o Use _raw forms for the spinlock we sleep whilst holding to avoid
CONFIG_PREEMPT complaining. I have lightly tested preempt on SMP with
the new patch, and it seems to work

regards
john
-- 
"That's just kitten-eating wrong."
	- Richard Henderson
