Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUG2QVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUG2QVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUG2QUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:20:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43451 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267597AbUG2QUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:20:07 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       jbarnes@engr.sgi.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	<20040728164457.732c2f1d.akpm@osdl.org>
	<m1d62f6351.fsf@ebiederm.dsl.xmission.com>
	<20040728180954.1f2baed9.akpm@osdl.org>
	<m1u0vr4luo.fsf@ebiederm.dsl.xmission.com>
	<138620000.1091110702@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jul 2004 10:19:12 -0600
In-Reply-To: <138620000.1091110702@[10.10.2.4]>
Message-ID: <m1llh2kcqn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> IIRC, what Adam did is to relocate the bottom 16MB of mem into the
> reserved buffer and execute into the bottom 16MB. Yes, that probably does
> leave some DMA issues that we should fix up as you suggest above, but I
> think it's good enough for a first pass at the problem.

I guess I don't have a problem with that as long as I don't have to
chase the bugs.  

If I do have to chase the bugs I would rather call the shutdown methods
and just say things don't _yet_ work in cases where it is not safe
to call them.

I guess I just like to be easily to explain what does not work _yet_.

With running at the same addresses we also have a rogue cpu problem as
well.  If we don't kill the cpu before the new kernel starts what happens
if it starts executing some random bit of the new code...

Eric
