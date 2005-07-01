Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVGAULQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVGAULQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVGAULP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:11:15 -0400
Received: from graphe.net ([209.204.138.32]:20144 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261521AbVGAUKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:10:15 -0400
Date: Fri, 1 Jul 2005 13:10:12 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
In-Reply-To: <20050629024903.GA21575@bragg.suse.de>
Message-ID: <Pine.LNX.4.62.0507011302090.19234@graphe.net>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel>
 <p73r7emuvi1.fsf@verdi.suse.de> <Pine.LNX.4.62.0506281238320.1734@graphe.net>
 <20050629024903.GA21575@bragg.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Andi Kleen wrote:

> On Tue, Jun 28, 2005 at 12:41:59PM -0700, Christoph Lameter wrote:
> > On Tue, 28 Jun 2005, Andi Kleen wrote:
> > 
> > > It's unfortunately useless because all the kernel is mapped in the
> > > same 2 or 4MB page has to be writable because it overlaps with real
> > > direct mapped memory.
> > 
> > The question is: Are syscall tables are supposed to be 
> > writable? If no then this patch should go in. If yes then forget about it.
> 
> I think it would make sense in theory to write protect them
> together with the kernel code and the modules
> (just to make root kit writing slightly harder)

Seems that you are evading the question that I asked. Are syscall tables 
supposed to be writable?

> BTW the kernel actually needs to write to code once
> to apply alternative(), but it would't be a problem to use
> a temporary mapping for this.

What does this have to do with the syscall table???

> > The ability to protect a readonly section may be another issue.
> 
> Well, it's the overriding issue here. Just pretending it's readonly
> when it isn't doesn't seem useful.

This is all are off-topic talking about a different issue. And we are 
already "pretending" that lots of other stuff in the readonly section is 
readonly.

The issue is correct placement of variables. Read only variables are 
placed in a different section and the syscall tables are read only and 
need to be place in the correct section.

