Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUARU5P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 15:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUARU5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 15:57:14 -0500
Received: from colin2.muc.de ([193.149.48.15]:33042 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263851AbUARU5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 15:57:12 -0500
Date: 18 Jan 2004 21:58:00 +0100
Date: Sun, 18 Jan 2004 21:58:00 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, jh@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add noinline attribute
Message-ID: <20040118205800.GA68521@colin2.muc.de>
References: <20040114083114.GA1784@averell> <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org> <20040115074834.GA38796@colin2.muc.de> <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org> <20040116101345.GA96037@colin2.muc.de> <20040118204700.GA31601@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118204700.GA31601@twiddle.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 12:47:00PM -0800, Richard Henderson wrote:
> On Fri, Jan 16, 2004 at 11:13:45AM +0100, Andi Kleen wrote:
> > Ok, here is a new patch that does the whole thing in generic code and for
> > modules too. I didn't bother to change the sort algorithm because the 
> > existing one works well enough.
> 
> One, you've still got the function marked __init.

Already fixed.

> 
> Two, the format of struct exception_table_entry is arch specific.
> That comparison won't work on Alpha, because "insn" is encoded 
> pc-relative.

Hmpf. Would an extable_compare() function in an asm-*/ file work ? 

-Andi
