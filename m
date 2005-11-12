Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVKLAxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVKLAxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 19:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVKLAxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 19:53:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750830AbVKLAxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 19:53:35 -0500
Date: Fri, 11 Nov 2005 16:53:33 -0800
From: Chris Wright <chrisw@osdl.org>
To: David Wagner <daw-usenet@taverner.CS.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] getrusage sucks
Message-ID: <20051112005333.GC7991@shell0.pdx.osdl.net>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <200511112338.20684.cloud.of.andor@gmail.com> <1131751433.3174.50.camel@localhost.localdomain> <20051111230223.GB7991@shell0.pdx.osdl.net> <dl3ad7$ikf$2@taverner.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dl3ad7$ikf$2@taverner.CS.Berkeley.EDU>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Wagner (daw@cs.berkeley.edu) wrote:
> Chris Wright  wrote:
> >It's already available via /proc w/out protection.  And ditto via posix
> >cpu timers.
> 
> If so, maybe that code should be fixed.  Where exactly in /proc would
> I find the getrusage() info of another process?

Just from /proc/[pid]/stat. (fs/proc/array.c::do_task_stat).

> Is there any argument
> that disclosing it to everyone is safe?  Or is it just that no one has
> ever given the security considerations much thought up till now?

I guess it keeps falling in the "too theoretical" category.  It can be
protected by policy, but default is open.

thanks,
-chris
