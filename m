Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUBDAX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbUBDAVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:21:39 -0500
Received: from gprs156-172.eurotel.cz ([160.218.156.172]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266247AbUBDAVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:21:14 -0500
Date: Tue, 3 Feb 2004 23:17:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tim Hockin <thockin@sun.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: NGROUPS 2.6.2rc2
Message-ID: <20040203221719.GA465@elf.ucw.cz>
References: <Pine.LNX.4.44.0401281757190.6213-100000@localhost.localdomain> <Pine.LNX.4.58.0401281007420.27790@home.osdl.org> <20040128222225.GH9155@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128222225.GH9155@sun.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Although I do believe that it would be better written as
> > 
> > 	#define MAXGROUPS (1000) /* Arbitrary, but we have to limit it somehere */
> > 
> > 	if ((unsigned) info->ngroups > MAXGROUPS)
> > 		return -ETOOEFFINGLARGE;
> > 
> > as I absolutely _despise_ code that tries to be too generic. 
> > 
> > What is it with CS classes that have removed "common sense" from the 
> > equation?
> 
> OK, there are two easy answers to this.  I can re-work it with a simple 32k
> limit that needs to be recompiled to change, or I can add a sysctl to
> control it (it appeared in an early version of this patch).

I guess static limit is okay for this...
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
