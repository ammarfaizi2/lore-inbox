Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbUDAQei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUDAQeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:34:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55743 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262471AbUDAQde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:33:34 -0500
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0404010750100.1116@ppc970.osdl.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0403311433240.1116@ppc970.osdl.org>
	 <1080776487.1991.113.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0403311550040.1116@ppc970.osdl.org>
	 <1080834032.2626.94.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0404010750100.1116@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1080837208.2626.111.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Apr 2004 17:33:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-04-01 at 17:02, Linus Torvalds wrote:

> > Worse, it doesn't seem to be implemented consistently either.  I've been
> > trying on a few other Unixen while writing this.  First on a Tru64 box,
> > and it is _not_ kicking off any IO at all for MS_ASYNC, except for the
> > 30-second regular sync.  The same appears to be true on FreeBSD.  And on
> > HP-UX, things go in the other direction: the performance of MS_ASYNC is
> > identical to MS_SYNC, both in terms of observed disk IO during the sync
> > and the overall rate of the msync loop.
> 
> If you check HP-UX, make sure it's a recent one. HPUX has historically 
> been just too broken for words when it comes to mmap() (ie some _really_ 
> strange semantics, like not being able to unmap partial mappings etc).

I'm not sure what counts as "recent" for that, but this was on HP-UX
11.  That's the most recent I've got access to.

--Stephen

