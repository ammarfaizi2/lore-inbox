Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266696AbUBMD0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266700AbUBMD0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:26:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:29058 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266696AbUBMD0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:26:12 -0500
Date: Fri, 13 Feb 2004 03:26:04 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-ID: <20040213032604.GI25499@mail.shareable.org>
References: <1076384799.893.5.camel@gaston> <Pine.LNX.4.58.0402100814410.2128@home.osdl.org> <20040210173738.GA9894@mail.shareable.org> <20040213002358.1dd5c93a.ak@suse.de> <20040212100446.GA2862@elte.hu> <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> One option is to mark the brk() VMA's as being grow-up (which they are), 
> and make get_unmapped_area() realize that it should avoid trying to 
> allocate just above grow-up segments or just below grow-down segments. 
> That's still something of a special case, but at least it's not "magic" 
> any more, now it's more of a "makes sense".

That reminds me.  What happens when grow-down stack VMAs finally bump
into another VMA.  Is there an unmapped guard page retained to segfault
the program, or does the program silently start overwriting the VMA it
bumped into?

-- Jamie
