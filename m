Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVBJAjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVBJAjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVBJAjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:39:01 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:61313
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S261989AbVBJAi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:38:57 -0500
Date: Wed, 9 Feb 2005 16:38:51 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Michael Ellerman <michael@ellerman.id.au>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Fix oops in alloc_zeroed_user_highpage() when page is
 NULL
In-Reply-To: <20050209205807.221d4591.michael@ellerman.id.au>
Message-ID: <Pine.LNX.4.58.0502091637060.9592@server.graphe.net>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
 <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <20050108135636.6796419a.davem@davemloft.net>
 <Pine.LNX.4.58.0501211206380.25925@schroedinger.engr.sgi.com>
 <20050209205807.221d4591.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Michael Ellerman wrote:

> The generic and IA-64 versions of alloc_zeroed_user_highpage() don't
> check the return value from alloc_page_vma(). This can lead to an oops
> if we're OOM. This fixes my oops on PPC64, but I haven't got an IA-64
> machine/compiler handy.

Patch looks okay to me. These are the only occurences as far as I can tell
after reviewing the alloc_zeroed_user_higpage implementations in
include/asm-*/page.h.


