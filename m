Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUARUrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 15:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUARUrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 15:47:11 -0500
Received: from are.twiddle.net ([64.81.246.98]:13969 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S263679AbUARUrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 15:47:10 -0500
Date: Sun, 18 Jan 2004 12:47:00 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, jh@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add noinline attribute
Message-ID: <20040118204700.GA31601@twiddle.net>
Mail-Followup-To: Andi Kleen <ak@colin2.muc.de>,
	Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
	Andrew Morton <akpm@osdl.org>, jh@suse.cz,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040114083114.GA1784@averell> <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org> <20040115074834.GA38796@colin2.muc.de> <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org> <20040116101345.GA96037@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116101345.GA96037@colin2.muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 11:13:45AM +0100, Andi Kleen wrote:
> Ok, here is a new patch that does the whole thing in generic code and for
> modules too. I didn't bother to change the sort algorithm because the 
> existing one works well enough.

One, you've still got the function marked __init.

Two, the format of struct exception_table_entry is arch specific.
That comparison won't work on Alpha, because "insn" is encoded 
pc-relative.


r~
