Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSLIDLj>; Sun, 8 Dec 2002 22:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSLIDLj>; Sun, 8 Dec 2002 22:11:39 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:48910 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S264815AbSLIDLi>; Sun, 8 Dec 2002 22:11:38 -0500
Message-Id: <200212090319.gB93J7p20606@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Detecting threads vs processes with ps or /proc
Date: Sun, 8 Dec 2002 21:18:44 -0600
X-Mailer: KMail [version 1.3.2]
Cc: acahalan@cs.uml.edu
References: <200212090024.gB90OTN25818@saturn.cs.uml.edu>
In-Reply-To: <200212090024.gB90OTN25818@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 December 2002 06:24 pm, Albert D. Cahalan wrote:
> Robert Love writes:
> > On Fri, 2002-12-06 at 14:56, Nick LeRoy wrote:
> >> I was considerring doing something like this as well.  From your
> >> experience,  does it work reliably?
> >
> > It never fails to detect threads (no false negatives).
>
> Testing the algorithm on idle test processes won't show
> this damn-obvious race condition:
>
> 1. you read the first thread's info
> 2. the second thread calls mmap() and/or takes a page fault
> 3. you read the second thread's info

Yeah, I thought of that, too.  Probably not too likely, of course, but it 
still there.  Murphy rules.

Robert:  Any thoughts on this?

-Nick
