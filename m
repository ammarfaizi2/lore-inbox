Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269775AbUINVXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269775AbUINVXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269699AbUINVUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:20:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:1424 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269226AbUINShu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:37:50 -0400
Date: Tue, 14 Sep 2004 11:37:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Roger Luethi <rl@hellgate.ch>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914113736.H1924@build.pdx.osdl.net>
References: <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040914163712.GT9106@holomorphy.com>; from wli@holomorphy.com on Tue, Sep 14, 2004 at 09:37:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III (wli@holomorphy.com) wrote:
> On Tue, 14 Sep 2004 08:37:58 -0700, William Lee Irwin III wrote:
> >> No, in general races of the form "permissions were altered after I
> >> checked them" can happen.
> 
> On Tue, Sep 14, 2004 at 06:01:50PM +0200, Roger Luethi wrote:
> > Can you make an example? Some scenario where this would be important?
> 
> Not particularly. It largely means poorly-coded apps may report gibberish.

Canonical example is access(2) followed by open(2), not really relevant
in this case.  However, exec setuid root app...when do you check, and
when to you fill in data to send back to user?  For /proc, this type of
check happens often (see things like may_ptrace_attach and
task_dumpable in fs/proc/base.c).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
