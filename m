Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVINWW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVINWW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVINWWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:22:25 -0400
Received: from [66.228.95.230] ([66.228.95.230]:27579 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S1030229AbVINWWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:22:24 -0400
To: Peter Staubach <staubach@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>
	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
	<784q8qrsad.fsf@sober-counsel.permabit.com>
	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
	<788xy2qas0.fsf@sober-counsel.permabit.com>
	<20050913183948.GE14889@dmt.cnet>
	<784q8okdfn.fsf@sober-counsel.permabit.com>
	<20050913193539.GB17222@dmt.cnet>
	<784q8oivp4.fsf@sober-counsel.permabit.com>
	<43287221.8020602@redhat.com>
	<7864t3h1xw.fsf@sober-counsel.permabit.com>
	<432883E5.6000004@redhat.com>
From: Assar <assar@permabit.com>
Date: 14 Sep 2005 18:20:23 -0400
In-Reply-To: <432883E5.6000004@redhat.com>
Message-ID: <78ek7rfg0o.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Staubach <staubach@redhat.com> writes:
> This code appears to assume that rcvbuf->page_base is zero here, but then
> uses rcvbuf->page_base when calculating where to place the null byte.  It
> seems to me that it should either use rcvbuf->page_base in both
> calculations or neither.

The meaning of page_len and page_base are not totally clear to me.  Is
it the case that the data starts at offset page_base and there is
page_len bytes of it.  If that's the case, I think the code is doing
the right thing.
