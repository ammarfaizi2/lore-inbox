Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbRE3THh>; Wed, 30 May 2001 15:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261882AbRE3TH1>; Wed, 30 May 2001 15:07:27 -0400
Received: from [64.64.109.142] ([64.64.109.142]:38162 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S261840AbRE3THW>; Wed, 30 May 2001 15:07:22 -0400
Message-ID: <3B1544B9.CE5F40DB@didntduck.org>
Date: Wed, 30 May 2001 15:06:33 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jimmie Mayfield <mayfield+kernel@sackheads.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon fast_copy_page revisited
In-Reply-To: <E155AmZ-0006NL-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > schemes in user-space but if I try in kernel space, I get the notorious crash inside
> > fast_copy_page.  (If there was some sort of fundamental hardware problem associated with
> > prefetch or streaming, wouldn't it also show up in user-space?)  Note: I've yet to try the
> 
> That has been one of the great puzzles. There are patterns that are very
> different in kernel space - notably physically linear memory and code running
> from a 4Mb tlb.

Have you tried hacking the kernel to only use 4k page tables (ie. filter
out the PSE capability bit)?  A shot in the dark, but probably worth
trying.

--

				Brian Gerst
