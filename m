Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUIZRmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUIZRmg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUIZRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 13:42:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55695 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261426AbUIZRmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 13:42:18 -0400
Date: Sun, 26 Sep 2004 19:42:17 +0200
From: Jan Kara <jack@suse.cz>
To: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Consistent kernel hang during heavy TCP connection handling load
Message-ID: <20040926174217.GB18172@atrey.karlin.mff.cuni.cz>
References: <NFBBICMEBHKIKEFBPLMCOEPOIHAA.aathan-linux-kernel-1542@cloakmail.com> <OMEGLKPBDPDHAGCIBHHJIEFDEIAA.aathan-linux-kernel-1542@cloakmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OMEGLKPBDPDHAGCIBHHJIEFDEIAA.aathan-linux-kernel-1542@cloakmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I would not normally quote an an entire message, but it contains data
> relevant to this problem.
> 
> The hang below occurs even outside of GDB, and also occurs after
> upgrading the kernel:
> 
> Linux bbox.memeplex.com 2.6.8-1.521 #1 Mon Aug 16 09:01:18 EDT 2004
> i686 i686 i386 GNU/Linux
> 
> 
> 
> Can anyone please give me a clue/pointer to tools/techniques that
> might help identify where in the kernel the hang occurs?  The system
> is so completely unresponsive when this occurs that I cannot provide
> any forensic data.
  How unresponsive exactly it is? Can you switch consoles and write? I
suppose ps(1) hangs... Is the disk working?

You can compile kernel with the magic Sysrq key (it is the option in the
kernel debugging section), run it and then press alt-sysrq-t and the
state of all processes will be printed. That might help...

> Does anyone's experience show that these types of hangs might occur
> purely as the result of use (or mis-use) of the pthreads library?  I'm
> looking for hints about what parts of my code to review.
> 
> There could easily be erroneous calls to pthread_detach(),
> pthread_join(), close(), and other system calls involved.
> 
> Thanks,
> Andrew Athan

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
