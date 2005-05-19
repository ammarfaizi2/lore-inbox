Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVESPLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVESPLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVESPJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:09:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24725 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262554AbVESPHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:07:08 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Arjan van de Ven <arjan@infradead.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org, "Gilbert, John" <JGG@dolby.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Adrian Bunk <bunk@stusta.de>,
       linux-os@analogic.com
In-Reply-To: <Pine.LNX.4.61L.0505191554530.10681@blysk.ds.pg.gda.pl>
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
	 <1116514412.6027.49.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61L.0505191554530.10681@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Date: Thu, 19 May 2005 17:06:57 +0200
Message-Id: <1116515217.6027.51.camel@laptopd505.fenrus.org>
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

On Thu, 2005-05-19 at 15:58 +0100, Maciej W. Rozycki wrote:
> On Thu, 19 May 2005, Arjan van de Ven wrote:
> 
> > > As I stated earlier, the page size passed in there is ELF_EXEC_PAGESIZE
> > > which may not be the same as PAGE_SIZE.
> > 
> > and that is good!
> > Some architectures have different page sizes for different
> > personalities, eg ia64 has 16Kb for ia64 binaries but 4kb for x86
> > binaries. "kernel" PAGE_SIZE would be wrong to give to x86 userspace
> > there.
> 
>  Well, as long as that value is what Linux expects (and respects!) for 
> calls like mprotect().

and that is the 4Kb/16Kb difference!
so it needs to be per elf type.. which is what is there now ;)

