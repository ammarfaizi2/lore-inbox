Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTETGnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 02:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTETGnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 02:43:32 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:21513 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263610AbTETGnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 02:43:32 -0400
Date: Tue, 20 May 2003 07:56:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Message-ID: <20030520075627.A28002@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Drepper <drepper@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030520014836.C7BDE2C069@lists.samba.org> <Pine.LNX.4.44.0305200821010.2445-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305200821010.2445-100000@localhost.localdomain>; from mingo@elte.hu on Tue, May 20, 2003 at 08:27:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 08:27:03AM +0200, Ingo Molnar wrote:
> yes, but the damage has been done already, and now we've got to start the
> slow wait for the old syscall to flush out of our tree.

Actually it should go away before 2.6.0.  sys_futex never was part of a
released stable kernel so having the old_ version around is silly.  I
Think it's enough time until 2.6 hits the roads for people to have those
vendor libc flushed out that use it.  (and sys_futex still isn't used
in the glibc CVS, only in the addon nptl package with pre-1 release
numbers.)

