Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUG2AWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUG2AWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUG2AUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:20:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:34281 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267370AbUG2AS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:18:57 -0400
Date: Wed, 28 Jul 2004 17:22:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ebiederm@xmission.com, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-Id: <20040728172204.2ecc5cdd.akpm@osdl.org>
In-Reply-To: <1091055311.31923.3.camel@localhost.localdomain>
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	<1091055311.31923.3.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Iau, 2004-07-29 at 00:17, Eric W. Biederman wrote:
> > What is your concern with stopping DMA?
> > - Not smashing the recovery routine.
> > - Getting a corrupted core dump because of on-going DMA?
> 
> Completely random happenings occurring when they are trivial to avoid.
> Given all the worries about SHA signed in kernel standalone objects I
> find it farcical that the same people don't even care about ensuring
> something isnt DMAing over their dump partition description.
> 

eh?  People do care.  The point here is that we should stop the DMA in the
dump kernel, not from within the broken kernel.

btw, if we simply insert a five-second-pause, what problems does that
leave?  Network Rx, which is OK.  Disk writes will have completed (?). 
What remains?

