Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUCCAtz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbUCCAtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:49:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261420AbUCCAtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:49:53 -0500
Date: Tue, 2 Mar 2004 16:49:51 -0800
From: Chris Wright <chrisw@osdl.org>
To: Rik Faith <faith@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
Message-ID: <20040302164951.Q22989@build.pdx.osdl.net>
References: <16451.25789.72815.763592@neuro.alephnull.com> <20040301122618.O22989@build.pdx.osdl.net> <chrisw@osdl.org> <16453.354.904646.836231@neuro.alephnull.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16453.354.904646.836231@neuro.alephnull.com>; from faith@redhat.com on Tue, Mar 02, 2004 at 04:49:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik Faith (faith@redhat.com) wrote:
> > Doesn't seem like CONFIG_AUDIT=n disables all the code.
>
> The bit tests in entry.S are still there, but those are the same tests
> that are used for ptrace, and there is nothing that sets the bits.  So,
> aside from that test, all of the code should be disabled.

I think, e.g. the code that calls audit_get/putname is still there.

> Except where noted below, I have either incorporated all your
> suggestions or made notes in the code to do so later.  The new patch is
> at: http://people.redhat.com/faith/audit/audit-20040302.1632.patch

Oops, I wasn't clear re: the static initialized data...I just meant to
give a couple examples, there were more:

+static int         audit_default = 0;
+static int         audit_pid = 0;
+static int         audit_rate_limit    = 0;
+static int         audit_freelist_count = 0;
etc...

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
