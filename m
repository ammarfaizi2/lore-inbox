Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUGWWlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUGWWlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUGWWlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 18:41:21 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:5100 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S268145AbUGWWlT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 18:41:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jul 2004 18:40:26 -0400 (EDT)
To: Roger Luethi <rl@hellgate.ch>
Cc: zanussi@us.ibm.com, linux-kernel@vger.kernel.org, karim@opersys.com,
       richardj_moore@uk.ibm.com, bob@watson.ibm.com,
       michel.dagenais@polymtl.ca
Subject: Re: LTT user input
In-Reply-To: <20040723191900.GA2817@k3.hellgate.ch>
References: <16640.10183.983546.626298@tut.ibm.com>
	<20040723100101.GA22440@k3.hellgate.ch>
	<16641.19483.708016.320557@tut.ibm.com>
	<20040723191900.GA2817@k3.hellgate.ch>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16641.36290.751769.126111@k42.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi writes:
 > On Fri, 23 Jul 2004 12:34:19 -0500, zanussi@us.ibm.com wrote:
 > > I agree that it would make sense for all these tools to at least share
 > > a common set of hooks in the kernel; it would be great if a single
 > > framework could serve them all too.  The question at the summit was
 > > 'why not use the auditing framework for tracing?'.  I haven't had a
 > > chance to look much at the code, but the performance numbers published
 > > for tracing syscalls using the auditing framework aren't encouraging
 > > for an application as intensive as tracing the entire system, as LTT
 > > does.
 > > 
 > > http://marc.theaimsgroup.com/?l=linux-kernel&m=107826445023282&w=2
 > 
 > Looking for a common base was certainly easier before one tracing
 > framework got merged. I don't claim to know if a common basic framework
 > would be beneficial, but I am somewhat amazed that not more effort has
 > gone into exploring this.

Argh.  I had up to this point been passively following this thread because
a while ago, prior to dtrace and other such work I, Karim, and others
invested quite of bit of effort and time responding to this group pointing
out the benefits of performance monitoring via tracing and

IN FACT this was exactly one of the points I ardently made.  Having each
subsystem set up their own monitoring was not only counter productive in
terms of time and implementation effort, but prevented a unified view of
performance from being achieved.  Nevertheless, it appears that some
subsystem tracing has been incorporated, though tbh I have not followed as
closely recently.

LTT and relayfs offered the best performing, most comprehensive solution,
and was reasonably unintrusive.  The work was integrated with dprodes,
allowing dynamic insertion and the zero cost non-monitored overhead
proclaimed by dtrace.  As Karim has pointed out in previous posts, though
the technical concerns that were raised were addressed, it didn't seem to
help as other nits would crop up appearing to imply that something else was
happening.  If indeed the remaining issue is whether there is a benefit to
a performance monitoring infrastructure, then I wonder how you would
interpret reactions to dtrace.

Robert Wisniewski
The K42 MP OS Project
IBM T.J. Watson Research Center
http://www.research.ibm.com/K42/

