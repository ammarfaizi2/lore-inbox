Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTJRCCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 22:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTJRCCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 22:02:13 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:29090 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261270AbTJRCCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 22:02:09 -0400
From: Matt Chapman <matthewc@cse.unsw.edu.au>
To: davidm@hpl.hp.com
Date: Sat, 18 Oct 2003 12:01:52 +1000
Cc: Andrew Morton <akpm@osdl.org>, bjorn.helgaas@hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-ID: <20031018020152.GA17826@cse.unsw.EDU.AU>
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017155028.2e98b307.akpm@osdl.org> <200310171725.10883.bjorn.helgaas@hp.com> <20031017165543.2f7e9d49.akpm@osdl.org> <16272.34681.443232.246020@napali.hpl.hp.com> <20031017174955.6c710949.akpm@osdl.org> <16272.39921.537615.433272@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16272.39921.537615.433272@napali.hpl.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 06:48:33PM -0700, David Mosberger wrote:
> >>>>> On Fri, 17 Oct 2003 17:49:55 -0700, Andrew Morton <akpm@osdl.org> said:
> 
>   Andrew> We _want_ to be able to read mmio ranges via /dev/mem, don't
>   Andrew> we?  I guess it has never come up because everyone uses
>   Andrew> kmem.
> 
> I just don't see how making a "dd if=/dev/mem" safe and allowing
> access to arbitrary physical memory can go to together.  Given that
> /dev/mem _is_ being used for accessing mmio space, is it really worth
> bothering trying to make such a "dd" safe?

Usually people who want to access MMIO devices would use mmap rather
than read/write.

But I do agree that the current semantics are not unreasonable and the
user should think about what they're doing before accessing random parts
of /dev/mem.

Matt

