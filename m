Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269175AbUIYBf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269175AbUIYBf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269173AbUIYBe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:34:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:31139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269175AbUIYBdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:33:49 -0400
Date: Fri, 24 Sep 2004 18:33:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: mlock(1)
Message-ID: <20040924183346.Z1924@build.pdx.osdl.net>
References: <41547C16.4070301@pobox.com> <20040924141731.7ced31f7.akpm@osdl.org> <20040924172611.Y1973@build.pdx.osdl.net> <20040924182808.0554ca6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040924182808.0554ca6a.akpm@osdl.org>; from akpm@osdl.org on Fri, Sep 24, 2004 at 06:28:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> >  Here's a simple (bit ugly) hack that does it (esp. the exec part).
> 
> Seems complicated.  IIRC it's just a matter of propagating a suitable flag
> in oldmm->def_flags into the new mm in copy_mm().

For fork.  Not exec.  W/out smth for exec, then a utility that does
equiv of MCL_FUTRE + exec won't work.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
