Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVESOoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVESOoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVESOoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:44:06 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:22801 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262535AbVESOnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:43:47 -0400
Date: Thu, 19 May 2005 15:43:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-os@analogic.com
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <1116512140.15866.42.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0505191532120.10681@blysk.ds.pg.gda.pl>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net> 
 <20050518195337.GX5112@stusta.de>  <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
  <20050519112840.GE5112@stusta.de>  <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
  <1116505655.6027.45.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl> 
 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>  <jeacmr5mzk.fsf@sykes.suse.de>
 <1116512140.15866.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Steven Rostedt wrote:

> > See create_elf_tables.  The aux table comes after the environment.
> 
> As I stated earlier, the page size passed in there is ELF_EXEC_PAGESIZE
> which may not be the same as PAGE_SIZE.

 Well, AT_PAGESZ is specified as "system page size".  If we pass something 
else, then it's asking for troubles.  What comes from AT_PAGESZ is used by 
userland for stuff like masking arguments for mmap() and mprotect() so 
it'd better be the right value.

  Maciej
