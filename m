Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVESOxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVESOxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVESOxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:53:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3733 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262531AbVESOxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:53:48 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Arjan van de Ven <arjan@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>,
       "Maciej W. Rozycki" <macro@linux-mips.org>, linux-os@analogic.com
In-Reply-To: <1116512140.15866.42.camel@localhost.localdomain>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	 <20050518195337.GX5112@stusta.de>
	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	 <20050519112840.GE5112@stusta.de>
	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	 <1116505655.6027.45.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
	 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>
	 <jeacmr5mzk.fsf@sykes.suse.de>
	 <1116512140.15866.42.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 19 May 2005 16:53:32 +0200
Message-Id: <1116514412.6027.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 10:15 -0400, Steven Rostedt wrote:
> On Thu, 2005-05-19 at 16:06 +0200, Andreas Schwab wrote:
> > "Richard B. Johnson" <linux-os@analogic.com> writes:
> > 
> > > Now, where is that 'auxiliary vevtor'??? I got a pointer to
> > > something to be executed before calling exit, I have an
> > > argument count, then a bunch of pointers (argv), terminating
> > > with a NULL, then another bunch of pointers (envp) terminating
> > > with a NULL.  Is there something after that??? If so, what's
> > > the contents of this thing?
> > 
> > See create_elf_tables.  The aux table comes after the environment.
> 
> As I stated earlier, the page size passed in there is ELF_EXEC_PAGESIZE
> which may not be the same as PAGE_SIZE.

and that is good!
Some architectures have different page sizes for different
personalities, eg ia64 has 16Kb for ia64 binaries but 4kb for x86
binaries. "kernel" PAGE_SIZE would be wrong to give to x86 userspace
there.


