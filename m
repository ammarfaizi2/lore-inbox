Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTGAR1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTGAR1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:27:41 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:39880 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S263103AbTGAR1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:27:40 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: What to expect with the 2.6 VM
Date: Mon, 30 Jun 2003 19:43:04 +0200
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307010238210.22576@skynet>
In-Reply-To: <Pine.LNX.4.53.0307010238210.22576@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306301943.04326.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 July 2003 03:39, Mel Gorman wrote:
> I'm writing a small paper on the 2.6 VM for a conference.

Nice stuff, and very timely.

>    In 2.4, Page Table Entries (PTEs) must be allocated from ZONE_ NORMAL as
>    the kernel needs to address them directly for page table traversal. In a
>    system with many tasks or with large mapped memory regions, this can
>    place significant pressure on ZONE_ NORMAL so 2.6 has the option of
>    allocating PTEs from high memory.

You probably ought to mention that this is only needed by 32 bit architectures 
with silly amounts of memory installed.  On that topic, you might mention 
that the VM subsystem generally gets simpler and in some cases faster (i.e., 
no more highmem mapping cost) in the move to 64 bits.

You also might want to mention pdflush.

Regards,

Daniel

