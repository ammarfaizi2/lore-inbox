Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269074AbUHXAMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269074AbUHXAMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268087AbUHXAJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:09:19 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:58631 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S269046AbUHXAHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 20:07:10 -0400
Date: Tue, 24 Aug 2004 01:07:07 +0100
From: John Levon <levon@movementarian.org>
To: Anton Blanchard <anton@samba.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-ID: <20040824000707.GA59224@compsoc.man.ac.uk>
References: <20040821192630.GA9501@compsoc.man.ac.uk> <20040821135833.6b1774a8.akpm@osdl.org> <200408211806.32566.jbarnes@sgi.com> <20040821231437.GB20175@compsoc.man.ac.uk> <20040822043359.GB8702@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822043359.GB8702@krispykreme>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1BzOqC-000DnV-1o*NujyHuspHSQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 02:34:00PM +1000, Anton Blanchard wrote:

> > That must be profile_rwsem in kernel/profile.c since the rest of the
> > code won't be doing anything. I imagine it needs RCUing.
> 
> Also profile_hook is called in the interrupt handler and has a global
> spinlock (profile_lock). If the notifier hooks used RCU then we wouldnt
> need this lock.

If that were the problem he'd see it with profile=2 though, since it
uses the same mechanism... should still be fixed of course.

john
