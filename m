Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754902AbWKNF33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbWKNF33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 00:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbWKNF33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 00:29:29 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:6737 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1754902AbWKNF33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 00:29:29 -0500
Date: Mon, 13 Nov 2006 21:29:17 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: proposal: remove unused macros
Message-Id: <20061113212917.3c5b8317.randy.dunlap@oracle.com>
In-Reply-To: <200611132119.17858.gene.heskett@verizon.net>
References: <200611131913.22872.m.kozlowski@tuxland.pl>
	<200611132119.17858.gene.heskett@verizon.net>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 21:19:17 -0500 Gene Heskett wrote:

> On Monday 13 November 2006 13:13, Mariusz Kozlowski wrote:
> >Hello,
> >
> >	Recently someone send a patch that fixed some old '#ifdef'ed code with
> > syntax error (stray brackets). The broken code was there for a long
> > time and nobody saw that. I digged some more and wrote a simple program
> > that counted '(' and ')' in the kernel code that emits apropriate text
> > if for a given file both numbers differ. That is probably dumb idea but
> > it worked :-) Quite fast I found a dozen of broken macros with syntax
> > errors etc. All of those macros are unused. I digged a bit deeper and
> > used '-Wunused-macros' flag which with causes 8340 new warnings to be
> > emited for 2.6.19-rc5-mm1 with 'allmodconfig'. For sure there are false
> > positives (see gcc man page) but even if i.e. 50% of them are fp then
> > we still have around 4k of unused macros scattered around the tree.
> >
> >To me this is a dead code. I can review the code causing these warnings
> > and prepare patches 'per subsystem' or whatever to address this issue.
> > That is if nobody opposes.
> 
> With regard to your parens checking code, I re-wrote from a broken 
> version, about 20 years ago, a utility to check all that.  I used it on 
> the coco/os9 systems at the time, then built it for the amiga, and 
> rebuilt it for linux a few years back.  It checks brackets, quotes in " 
> style and ' style and ;, etc stuff.  I called mine cntx, and I've used it 
> occasionally here, but haven't had the need/urge to test any kernel code 
> with it so far.
> 
> If anyone is interested, and the list will take attachments of that 
> nature, I'd be honored to share it.  What say you all?

I'm interested.

Thanks,
---
~Randy
