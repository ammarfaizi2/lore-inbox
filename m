Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVESPDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVESPDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVESPCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:02:18 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:48136 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262536AbVESO62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:58:28 -0400
Date: Thu, 19 May 2005 15:58:32 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org, "Gilbert, John" <JGG@dolby.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Adrian Bunk <bunk@stusta.de>,
       linux-os@analogic.com
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <1116514412.6027.49.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61L.0505191554530.10681@blysk.ds.pg.gda.pl>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net> 
 <20050518195337.GX5112@stusta.de>  <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
  <20050519112840.GE5112@stusta.de>  <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
  <1116505655.6027.45.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl> 
 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>  <jeacmr5mzk.fsf@sykes.suse.de>
  <1116512140.15866.42.camel@localhost.localdomain>
 <1116514412.6027.49.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Arjan van de Ven wrote:

> > As I stated earlier, the page size passed in there is ELF_EXEC_PAGESIZE
> > which may not be the same as PAGE_SIZE.
> 
> and that is good!
> Some architectures have different page sizes for different
> personalities, eg ia64 has 16Kb for ia64 binaries but 4kb for x86
> binaries. "kernel" PAGE_SIZE would be wrong to give to x86 userspace
> there.

 Well, as long as that value is what Linux expects (and respects!) for 
calls like mprotect().

  Maciej
