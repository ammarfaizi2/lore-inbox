Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVJ2Icz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJ2Icz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVJ2Icz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:32:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26334 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750700AbVJ2Icy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:32:54 -0400
Subject: Re: [Bug 5039] high cpu usage (softirq takes 50% all the time)
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bugme-daemon@kernel-bugs.osdl.org, morfic@gentoo.org, kraftb@kraftb.at,
       migo@abp.pl, linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
In-Reply-To: <20051029010945.623a8dab.akpm@osdl.org>
References: <200510290754.j9T7sqAg027452@fire-1.osdl.org>
	 <20051029010945.623a8dab.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 10:32:34 +0200
Message-Id: <1130574755.2908.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-29 at 01:09 -0700, Andrew Morton wrote:
> bugme-daemon@kernel-bugs.osdl.org wrote:
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=5039
> > 
> 
> Well this is a depressing saga.  A bunch of people whose machines appear to
> be spending 50% CPU time in softirq processing.  Some find that `noapic'
> fixes it and some dont.  Some are on x86_64, some are on x86.
> 
> I suspect we have multiple bugs here.  It's quite a mess.
> 
> Could the reporters please, via a reply-to-all to this email:
> 
> a) test 2.6.14.
> 
> b) summarise the current status of your bug (what CPU type, what are the
>    symptoms, any known workarounds, etc).
> 
> c) Generate a kernel profile (see Documentation/basic_profiling.txt)

d) get a /proc/interrupts

to see if there's some screaming irq.. and if so which one

