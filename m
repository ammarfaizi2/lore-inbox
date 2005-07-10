Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVGJDgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVGJDgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 23:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVGJDgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 23:36:10 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:31927 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261833AbVGJDgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 23:36:07 -0400
X-ORBL: [63.202.173.158]
Date: Sat, 9 Jul 2005 20:35:59 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
Message-ID: <20050710033559.GA31057@taniwha.stupidest.org>
References: <20050709144116.GA9444@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709144116.GA9444@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 04:41:16PM +0200, Ingo Molnar wrote:

> this patch pushes the creation of a rare signal frame (SIGBUS or
> SIGSEGV) into a separate function, thus saving stackspace in the
> main do_page_fault() stackframe. The effect is 132 bytes less of
> stack used by the typical do_page_fault() invocation - resulting in
> a denser cache-layout.

does the benefit actually show up anywhere?
