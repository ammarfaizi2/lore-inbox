Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbTBLDlC>; Tue, 11 Feb 2003 22:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbTBLDlB>; Tue, 11 Feb 2003 22:41:01 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12174 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266041AbTBLDlB>; Tue, 11 Feb 2003 22:41:01 -0500
Date: Tue, 11 Feb 2003 19:50:41 -0800
Message-Id: <200302120350.h1C3ofQ19892@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: Linus Torvalds's message of  Tuesday, 11 February 2003 19:18:33 -0800 <Pine.LNX.4.44.0302111912580.2667-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
X-Zippy-Says: I'm EXCITED!!  I want a FLANK STEAK WEEK-END!!  I think I'm JULIA CHILD!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You just have to read it in a way that says "partial results are
> permissible, and are part of the normal behaviour". And then the fact that
> when ^Z happens you get partial results from pipes is not "different
> behaviour" from a qualitative standpoint - even though in fact we'd get a
> full result if the ^Z didn't happen.

I'm not talking about reading from pipes, that was your example.  I was
talking about calls with timeouts, like semop, whose interface do not
permit partial results.  Anyway, I find your reading insupportable even in
reference to read or write.  read and write are explicitly specified to
return partial results when interrupted by a signal, and are not permitted
to do so otherwise.  1003.1-2001 2.4.4 defines "interrupted" in reference
only to signals that are caught.
