Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVESOQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVESOQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVESOQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:16:46 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:52653 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262517AbVESOQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:16:25 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Steven Rostedt <rostedt@goodmis.org>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org, "Gilbert, John" <JGG@dolby.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Adrian Bunk <bunk@stusta.de>,
       Arjan van de Ven <arjan@infradead.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>, linux-os@analogic.com
In-Reply-To: <jeacmr5mzk.fsf@sykes.suse.de>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	 <20050518195337.GX5112@stusta.de>
	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	 <20050519112840.GE5112@stusta.de>
	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	 <1116505655.6027.45.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
	 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>
	 <jeacmr5mzk.fsf@sykes.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 10:15:40 -0400
Message-Id: <1116512140.15866.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 16:06 +0200, Andreas Schwab wrote:
> "Richard B. Johnson" <linux-os@analogic.com> writes:
> 
> > Now, where is that 'auxiliary vevtor'??? I got a pointer to
> > something to be executed before calling exit, I have an
> > argument count, then a bunch of pointers (argv), terminating
> > with a NULL, then another bunch of pointers (envp) terminating
> > with a NULL.  Is there something after that??? If so, what's
> > the contents of this thing?
> 
> See create_elf_tables.  The aux table comes after the environment.

As I stated earlier, the page size passed in there is ELF_EXEC_PAGESIZE
which may not be the same as PAGE_SIZE.

-- Steve


