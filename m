Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVKWWuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVKWWuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVKWWuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:50:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34008 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932299AbVKWWuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:50:13 -0500
Date: Wed, 23 Nov 2005 23:48:03 +0100
From: Pavel Machek <pavel@suse.cz>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: rfc/rft: use r10 as current on x86-64
Message-ID: <20051123224803.GE24220@elf.ucw.cz>
References: <20051122165204.GG1127@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122165204.GG1127@kvack.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The patch below converts x86-64 to use r10 as the current pointer instead 
> of gs:pcurrent.  This results in a ~34KB savings in the code segment of 
> the kernel.  I've tested this with running a few regular applications, 
> plus a few 32 bit binaries.  If this patch is interesting, it probably 
> makes sense to merge the thread info structure into the task_struct so 
> that the assembly bits for syscall entry can be cleaned up.  Comments?

34KB smaller is nice, but is not it also 30% slower? Plus some inline
assembly *will* have %r10 hardcoded, no? I'd be afraid around crypto
code, for example.
								Pavel
-- 
Thanks, Sharp!
