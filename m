Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTEUKLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 06:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTEUKLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 06:11:16 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:29203 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261847AbTEUKLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 06:11:13 -0400
Date: Wed, 21 May 2003 11:24:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Message-ID: <20030521112411.A12171@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Drepper <drepper@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030521023627.F07062C015@lists.samba.org> <Pine.LNX.4.44.0305211140120.2045-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305211140120.2045-100000@localhost.localdomain>; from mingo@elte.hu on Wed, May 21, 2003 at 11:48:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 11:48:49AM +0200, Ingo Molnar wrote:
> no. The concept is: "dont cause the user any pain". Reshuffling the
> syscall internally and providing new interfaces for the feature to be
> exposed in a cleaner way is perfectly OK as long as this does not hurt
> anything else - and it does not in this case. New glibc will use the new
> syscalls and will fall back to the old one if they are -ENOSYS, so new
> glibc will work on older kernels as well. Old glibc will work with old
> kernels and new kernels as well. This is being done for other interfaces
> currently, this is the only mechanism to 'flush out' old syscalls
> gracefully.

I don't think anyone disagreed with that (at least not me).  The only
thing I argued is that we don't need the usual flush-out period of two
stable series because this syscall never was implemented in any relead
stable kernel but rather a much shorter one so that this feature never
hits a released stable kernel.

Linus disagrees strongly so we'll have to keep this crap around for five
years - that's just yet another bit of bloat growing everyones kernel
but no irreperable damage.

