Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267999AbUHUXOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267999AbUHUXOk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 19:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268003AbUHUXOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 19:14:40 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:36365 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S267999AbUHUXOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 19:14:39 -0400
Date: Sun, 22 Aug 2004 00:14:38 +0100
From: John Levon <levon@movementarian.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, oprofile-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, anton@samba.org, phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-ID: <20040821231437.GB20175@compsoc.man.ac.uk>
References: <20040821192630.GA9501@compsoc.man.ac.uk> <20040821135833.6b1774a8.akpm@osdl.org> <200408211806.32566.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408211806.32566.jbarnes@sgi.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Byf4I-000D9w-BF*whxAdZ7XMw.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 06:06:31PM -0400, Jesse Barnes wrote:

> I'll give it a go on Monday, when I have some more time reserved on the 512p 
> system.  Last time I tried enabling oprofile, the system wouldn't boot or at 
> least got so slow that I didn't want to wait for it (i.e. init started, but 
> the system pretty much hung part way through the init scripts).

That must be profile_rwsem in kernel/profile.c since the rest of the
code won't be doing anything. I imagine it needs RCUing.

> If it boots, I'll try collecting some info.  John, will the oprofile tools in 
> RHEL3 work with 2.6.8.1-mm3 + these patches?

No idea, I don't have time to track what Red Hat do or don't use. I
recommend oprofile CVS or the last release.

john
