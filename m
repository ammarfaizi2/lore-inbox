Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVI1IZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVI1IZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 04:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVI1IZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 04:25:34 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:8404 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030214AbVI1IZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 04:25:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][Fix] Fix Bug #4959 (take 2)
Date: Wed, 28 Sep 2005 10:25:56 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
References: <200509241936.12214.rjw@sisk.pl> <200509280126.26701.rjw@sisk.pl> <20050927234329.GC2381@elf.ucw.cz>
In-Reply-To: <20050927234329.GC2381@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281025.56633.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 28 of September 2005 01:43, Pavel Machek wrote:
> Hi!
> 
> > > > I can reserve the static buffer (10 pages) in suspend.c and mark it as nosave.
> > > > The code that creates the mappings can stay in suspend.c either except it
> > > > won't need to call get_usable_page() and free_eaten_memory() any more
> > > > (__next_page() can be changed to get pages from the static buffer instead
> > > > of allocating them).  The code can also be simplified a bit, as we assume that
> > > > there will be only one PGD entry in the direct mapping.
> > > > 
> > > > If that sounds good to you, please confirm.
> > > 
> > > 8GB limit seems good to me -- as long as it makes code significantly
> > > simpler. It would be nice if it was <20 lines.
> > 
> > It is more than that, but it seems to be quite simple anyway.
> > 
> > The new patch follows.
> 
> Thanks, seems okay to me.

Thanks for reviewing.

If you don't mind, I'll change arch_prepare_suspend() a bit so that the
RAM sizes are printed in KB and repost the patch with a changelog.

Greetings,
Rafael
