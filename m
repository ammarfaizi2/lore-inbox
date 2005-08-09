Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVHICBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVHICBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 22:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVHICBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 22:01:46 -0400
Received: from graphe.net ([209.204.138.32]:47549 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932406AbVHICBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 22:01:45 -0400
Date: Mon, 8 Aug 2005 19:01:37 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
In-Reply-To: <1123551167.9451.5.camel@localhost>
Message-ID: <Pine.LNX.4.62.0508081858040.32489@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net> 
 <Pine.LNX.4.62.0507272018060.11863@graphe.net>  <20050728074116.GF6529@elf.ucw.cz>
  <Pine.LNX.4.62.0507280804310.23907@graphe.net>  <20050728193433.GA1856@elf.ucw.cz>
  <Pine.LNX.4.62.0507281251040.12675@graphe.net>  <Pine.LNX.4.62.0507281254380.12781@graphe.net>
  <20050728212715.GA2783@elf.ucw.cz> <20050728213254.GA1844@elf.ucw.cz> 
 <Pine.LNX.4.62.0507281456240.14677@graphe.net> <1123551167.9451.5.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Nigel Cunningham wrote:

> Just to let you know that I have it working with Suspend2. One thing I
> am concerned about is that we still need a way of determining whether a
> process has been signalled but not yet frozen. At the moment you just
> check p->todo, but if/when other functionality begins to use the todo
> list, this will be unreliable.
> 

No it wont. A process that has notifications to process should do that 
before being put into the freezer. Only after the notification list is 
empty will the process be notified and as long as the notification is 
pending no second notification should happen.

> I'm happy to supply the patches I'm using if you want to compare. (I
> retained the other freezer improvements, so it wouldn't just be bug
> fixes against your patches).

I am not sure how to sort that out. I guess post the current patches that 
you got and then we see how to continue from there.

