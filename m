Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUHVEej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUHVEej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 00:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUHVEej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 00:34:39 -0400
Received: from ozlabs.org ([203.10.76.45]:5040 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266085AbUHVEei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 00:34:38 -0400
Date: Sun, 22 Aug 2004 14:34:00 +1000
From: Anton Blanchard <anton@samba.org>
To: John Levon <levon@movementarian.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-ID: <20040822043359.GB8702@krispykreme>
References: <20040821192630.GA9501@compsoc.man.ac.uk> <20040821135833.6b1774a8.akpm@osdl.org> <200408211806.32566.jbarnes@sgi.com> <20040821231437.GB20175@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821231437.GB20175@compsoc.man.ac.uk>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> That must be profile_rwsem in kernel/profile.c since the rest of the
> code won't be doing anything. I imagine it needs RCUing.

Also profile_hook is called in the interrupt handler and has a global
spinlock (profile_lock). If the notifier hooks used RCU then we wouldnt
need this lock.

Anton
