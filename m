Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVAVByc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVAVByc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 20:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVAVByc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 20:54:32 -0500
Received: from news.suse.de ([195.135.220.2]:21219 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262405AbVAVByb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 20:54:31 -0500
Date: Sat, 22 Jan 2005 02:54:21 +0100
From: Andi Kleen <ak@suse.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: Something very strange on x86_64 2.6.X kernels
Message-ID: <20050122015421.GA27060@wotan.suse.de>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de> <41F01A50.1040109@cosmosbay.com> <20050121162601.GA8469@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121162601.GA8469@vana.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 05:26:01PM +0100, Petr Vandrovec wrote:
> On Thu, Jan 20, 2005 at 09:53:36PM +0100, Eric Dumazet wrote:
> > 
> > Examining linux sources, I found that 0xffffe000 is 'special' (ia 32 
> > vsyscall) and 0xffffe600 is about sigreturn subsection of this special area.
> > 
> > Is it possible some vm trick just kicks in and corrupts my true 64bits 
> > program ?
> 
> Maybe I already missed answer, but try patch below.  It is definitely bad
> to mark syscall page as global one...

Patch looks good thanks. Ugh, what a stupid bug.

I applied the patch to my tree.

-Andi
