Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135686AbRDXSYj>; Tue, 24 Apr 2001 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135704AbRDXSY3>; Tue, 24 Apr 2001 14:24:29 -0400
Received: from goat.cs.wisc.edu ([128.105.166.42]:44807 "EHLO goat.cs.wisc.edu")
	by vger.kernel.org with ESMTP id <S135686AbRDXSYP>;
	Tue, 24 Apr 2001 14:24:15 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
From: Victor Zandy <zandy@cs.wisc.edu>
Date: 24 Apr 2001 13:21:41 -0500
Message-ID: <cpxitjurwei.fsf@goat.cs.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.3
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds writes:
> Ahh.. This actually _does_ look like a race on "current->flags": 
> PTRACE_ATTACH will do a 
> 
>         child->flags |= PF_PTRACED; 
> 
> without waiting for the child to have stopped. 

I can see how this could case PF_USEDFPU to be cleared inadvertently,
but I do not have any ideas for testing this.  Is it clear that this
is the source of the problem?

What would be involved in backporting the split ptrace flags to 2.2?
Are there other solutions?

Vic
