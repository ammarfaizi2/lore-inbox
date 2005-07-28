Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVG1V55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVG1V55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVG1V55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:57:57 -0400
Received: from graphe.net ([209.204.138.32]:61374 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261579AbVG1V5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:57:37 -0400
Date: Thu, 28 Jul 2005 14:57:35 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
In-Reply-To: <20050728213254.GA1844@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0507281456240.14677@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
 <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz>
 <Pine.LNX.4.62.0507280804310.23907@graphe.net> <20050728193433.GA1856@elf.ucw.cz>
 <Pine.LNX.4.62.0507281251040.12675@graphe.net> <Pine.LNX.4.62.0507281254380.12781@graphe.net>
 <20050728212715.GA2783@elf.ucw.cz> <20050728213254.GA1844@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Pavel Machek wrote:

> Hi!
> 
> > > Introduce a todo notifier in the task_struct so that a task can be told to do
> > > certain things. Abuse the suspend hooks try_to_freeze, freezing and refrigerator
> > > to establish checkpoints where the todo list is processed. This will break software
> > > suspend (next patch fixes and cleans up software suspend).
> > 
> > Ugh, this conflicts with stuff in -mm tree rather badly... In part
> > thanks to patch by you that was already applied.
> > 
> > I fixed up rejects manually (but probably lost fix or two in
> > progress), and will test.

Dont fix it up. Remove the ealier patch.

> > 
> > You are doing rather intrusive changes. Is testing them too much to
> > ask? I'm pretty sure you can get i386 machine to test swsusp on...
> 
> (And yes, I did apply the whole series. It would be nice if next
> series was relative to -mm, it already contains some of your changes).

mm contains the TIF_FREEZE changes that need to be undone. And yes I 
tested it on a i386 with suspend to disk and it worked fine.

