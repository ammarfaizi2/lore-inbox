Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUASAxC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 19:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUASAxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 19:53:02 -0500
Received: from are.twiddle.net ([64.81.246.98]:30097 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S264321AbUASAw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 19:52:57 -0500
Date: Sun, 18 Jan 2004 16:52:44 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, jh@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add noinline attribute - new extable sort patch
Message-ID: <20040119005244.GB32149@twiddle.net>
Mail-Followup-To: Andi Kleen <ak@colin2.muc.de>,
	Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
	Andrew Morton <akpm@osdl.org>, jh@suse.cz,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040114083114.GA1784@averell> <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org> <20040115074834.GA38796@colin2.muc.de> <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org> <20040116101345.GA96037@colin2.muc.de> <20040118204700.GA31601@twiddle.net> <20040118230743.GA12989@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118230743.GA12989@colin2.muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 12:07:43AM +0100, Andi Kleen wrote:
> I looked at it more closely now. Alpha (and IA64 which uses the same
> format) would be relatively easy to do. But sparc and sparc64 have a
> very strange different format which would be too complicated to handle.

I don't think that's true.  Yes, sparc and sparc64 have paired
entries, but they should still sort consecutive.  If there were
an entry that, after sorting, came between them, something would
be Very Wrong.


r~
