Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWILG3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWILG3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 02:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWILG3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 02:29:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59837 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751351AbWILG3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 02:29:16 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
References: <1157947414.31071.386.camel@localhost.localdomain>
	<1157965071.23085.84.camel@localhost.localdomain>
	<1157966269.3879.23.camel@localhost.localdomain>
	<1157969261.23085.108.camel@localhost.localdomain>
	<m1pse17hzi.fsf@ebiederm.dsl.xmission.com>
	<1158040605.15465.70.camel@localhost.localdomain>
Date: Tue, 12 Sep 2006 00:27:57 -0600
In-Reply-To: <1158040605.15465.70.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Tue, 12 Sep 2006 15:56:45 +1000")
Message-ID: <m1d5a17g5u.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> I've not gone too much in details about write combining (we need to do
> something about it but I don't want to mix problems) but I did define
> that the ordered accessors aren't guaranteed to provide write combining
> on storage mapped with WC enabled while the relaxed or non ordered ones
> are. That should be enough at this point.

Sounds good.

> Later, we should look into providing an ioremap_wc() and possibly page
> table flags for write combining userland mappings. Time to get rid of
> MTRRs for graphics :) And infiniband-style stuff seems to want that too.

ioremap_wc is actually the easy half.  I have an old patch that handles
that.  The trick is to make certain multiple people don't map the same
thing with different attributes.  Unfortunately I haven't had time to
work through that one yet.

Eric

