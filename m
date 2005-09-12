Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVILRQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVILRQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVILRQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:16:16 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:46626 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932107AbVILRQP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:16:15 -0400
Date: Mon, 12 Sep 2005 19:17:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Jackson <pj@sgi.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined by GCC from 2.95 to current CVS)
Message-ID: <20050912171759.GA11973@mars.ravnborg.org>
References: <97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com> <20050910014543.1be53260.akpm@osdl.org> <4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com> <20050910150446.116dd261.akpm@osdl.org> <E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com> <20050910174818.579bc287.akpm@osdl.org> <93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com> <20050912010954.70ac90e2.pj@sgi.com> <43259C9E.1040300@zytor.com> <20050912084756.4fa2bd07.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912084756.4fa2bd07.pj@sgi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 08:47:56AM -0700, Paul Jackson wrote:
> hpa wrote:
> > The only sane thing is to have a set of ABI headers with a clean, 
> > specific set of rules, which is included by the kernel private headers, 
> > as well as userspace.
> 
> Why must the ABI headers be included by both kernel and user headers to
> be sane?

Thats the only way to keep them consistent.
Likewise we do not have seperate copies of the core headers for
individual subsystems.

If one have to edit in two places when adding a list of constants for
example you can be sure at one point in time the second place is
forgotten.
What does this separation where user space headers live a life outside
the kernel buy us? As kernel developers we are free to think on the user
psace side - thats nice sometimes. But hiding in a hole is not the
way we create the best interfaces. That has the kernel model shwed many
times. It requires publicity and frequent usage to be good. Two thinks
that is harder to get when we hide.

But seen form the userspace perspective this is horrible. 
They have to maintain a set of almost duplicated headers with 
various licenses, sync problems etc. for absolutely no gain.

	Sam
