Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVAGWje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVAGWje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVAGWin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:38:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:55229 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261677AbVAGWgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:36:39 -0500
Date: Fri, 7 Jan 2005 14:36:38 -0800
From: Chris Wright <chrisw@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, hch@infradead.org,
       mingo@elte.hu, chrisw@osdl.org, alan@lxorguk.ukuu.org.uk, joq@io.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107143638.L2357@build.pdx.osdl.net>
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <200501072207.j07M7Lda004987@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200501072207.j07M7Lda004987@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, Jan 07, 2005 at 05:07:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> On Fri, 07 Jan 2005 13:49:41 PST, Andrew Morton said:
> 
> > Chris Wright <chrisw@osdl.org> wrote:
> 
> > > Last I checked they could be controlled separately in that module.  It
> > > has been suggested (by me and others) that one possible solution would
> > > be to expand it to be generic for all caps.
> > 
> > Maybe this is the way?
> 
> We already *know* how to (in principle) fix the capabilities system to make
> it useful.  We should probably investigate doing that and at the same time
> fixing the current CAP_SYS_ADMIN mess (which we also have at least some ideas
> on fixing). The remaining problem is possible breakage of software that's doing
> capability things The Old Way (as the inheritance rules are incompatible).

Fixing CAP_SYS_ADMIN whole other can o' worms.  No point in tangling the
two.

> Linus at one time said that a 2.7 might open if there was some issue that
> caused enough disruption to require a fork - could this be it, or does somebody
> have a better way to address the backward-combatability problem?

There's at least two ways.  Introduce a new capability module or introduce
a PF flag to opt in.  Neither are great

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
