Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273078AbTHNS2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274822AbTHNS2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:28:16 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:58240 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S273078AbTHNS2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:28:15 -0400
Date: Thu, 14 Aug 2003 19:27:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matt Wilson <msw@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] revert zap_other_threads breakage, disallow CLONE_THREAD without CLONE_DETACHED
Message-ID: <20030814182757.GA11623@mail.jlokier.co.uk>
References: <20030814175309.GC10889@mail.jlokier.co.uk> <Pine.LNX.4.44.0308141101110.1692-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308141101110.1692-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > Don't forget to mention that software that may be run on 2.5 kernels
> > needs to set both bits, else won't work as expected.
> 
> Well, the CLONE_DETACHED without CLONE_THREAD case was never legal, and my
> current patch will actually warn about the newly disallowed case too. I've
> not gotten any warnings with RH-9, and I don't think anybody else has a 
> new enough glibc to even use CLONE_THREAD at all.

I'm thinking of programs that don't use Glibc, but do use these features.
Perhaps I'm the only person who writes such code :)

> But yes, there will be a warning, at least for a time (and eventually 
> we'll just return -EINVAL silently - ie the program will _fail_ the 
> clone(), it won't just act strangely).

-EINVAL would be great.

-- Jamie
