Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVF1TpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVF1TpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVF1TnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:43:15 -0400
Received: from graphe.net ([209.204.138.32]:35531 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261206AbVF1TmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:42:00 -0400
Date: Tue, 28 Jun 2005 12:41:59 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
In-Reply-To: <p73r7emuvi1.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.62.0506281238320.1734@graphe.net>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel>
 <p73r7emuvi1.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Andi Kleen wrote:

> It's unfortunately useless because all the kernel is mapped in the
> same 2 or 4MB page has to be writable because it overlaps with real
> direct mapped memory.

The question is: Are syscall tables are supposed to be 
writable? If no then this patch should go in. If yes then forget about it.
On IA64 they are readonly and so I thought they should also be readonly
on i386 and x86_64.

The ability to protect a readonly section may be another issue.

