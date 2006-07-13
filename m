Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWGMNhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWGMNhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWGMNhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:37:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:17090 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030220AbWGMNhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:37:05 -0400
Date: Thu, 13 Jul 2006 08:36:02 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, hugh@veritas.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-ID: <20060713133602.GH14665@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com> <20060627054612.GA15657@sergelap.austin.ibm.com> <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com> <20060711194932.GA27176@sergelap.austin.ibm.com> <20060711171752.4993903a.akpm@osdl.org> <20060712032647.GA24595@sergelap.austin.ibm.com> <20060711204637.bba6e966.akpm@osdl.org> <20060712230228.GA19656@sergelap.austin.ibm.com> <20060713023829.c19881be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713023829.c19881be.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):

> Again: why is this so hard?  It shouldn't be.  Perhaps because loop is
> using completions in bizarre ways where it should be using
> wake_up_process(), wait_event(), etc.

Ah.

wait_event() actually seems like the way to go - I'll try to follow the
example in fs/ocfs2/journal.c.

Still I'd also like to patch kthread to correctly handle an already
exited thread.  Would that be acceptable, or is requiring the thread not
to exit prematurely considered desirable?

thanks,
-serge
