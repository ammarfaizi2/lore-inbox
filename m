Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbUL0Bm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbUL0Bm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 20:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbUL0Bmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 20:42:43 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:59363 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261736AbUL0Blo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 20:41:44 -0500
Date: Sun, 26 Dec 2004 17:41:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: M?ns Rullg?rd <mru@inprovide.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, Wayne Scott <wscott@work.bitmover.com>
Subject: Re: lease.openlogging.org is unreachable
Message-ID: <20041227014138.GA8773@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	M?ns Rullg?rd <mru@inprovide.com>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org,
	Wayne Scott <wscott@work.bitmover.com>
References: <20041226181837.GA28786@work.bitmover.com> <200412270031.iBR0VBQq032074@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412270031.iBR0VBQq032074@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 09:31:11PM -0300, Horst von Brand wrote:
> > The other answer, which I'm happy to consider, is to come up with a unique
> > id on a per host basis and use that for the leases.  That's not a fun task,
> > does anyone have code (BSD license please) which does that?
> 
> MAC of eth0?

As others have pointed out that won't work.

I'm trying to remember why we get leases on a per host basis and I think
it is for a simple reason, NFS.  We update the leases in your home
directory and if your home directory is nfs mounted then we can corrupt
the leases file due to races (yes, we saw this all the time when we had
one leases file).  So we stick the leases for a particular host in that
host's file.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
