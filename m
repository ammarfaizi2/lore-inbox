Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314069AbSDQGBn>; Wed, 17 Apr 2002 02:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314070AbSDQGBm>; Wed, 17 Apr 2002 02:01:42 -0400
Received: from zero.tech9.net ([209.61.188.187]:24588 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314069AbSDQGBl>;
	Wed, 17 Apr 2002 02:01:41 -0400
Subject: Re: Why HZ on i386 is 100 ?
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mark Mielke <mark@mark.mielke.cc>, davidm@hpl.hp.com,
        Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204162227530.15675-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 17 Apr 2002 02:01:42 -0400
Message-Id: <1019023303.1670.37.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-17 at 01:34, Linus Torvalds wrote:

> No, it also makes it much easier to convert to/from the standard UNIX time
> formats (ie "struct timeval" and "struct timespec") without any surprises,
> because a jiffy is exactly representable in both if you have a HZ value
> of 100 or 100, but not if your HZ is 1024.

Exactly - this was my issue.  So what _was_ the rationale behind Alpha
picking 1024 (and others following)?  More importantly, can we change to
1000?

	Robert Love

