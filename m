Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267579AbRGNGD3>; Sat, 14 Jul 2001 02:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267580AbRGNGDT>; Sat, 14 Jul 2001 02:03:19 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:37550 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267579AbRGNGDG>; Sat, 14 Jul 2001 02:03:06 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Chuck Winters" <cwinters@atl.lmco.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Number of File descriptors
Date: Fri, 13 Jul 2001 23:03:07 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMMEMGCHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010713095934.A6100@atl.lmco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello All,
> 	My interest has been peaked by a recent email.  At one
> point, I heard two people speaking
> about how some database guy wanted to have 2000 open files(or
> something crazy like that).
> They said that he must be crazy because the kernel does a
> sequential search through the open
> file descriptors.  Anyway, I read a posting an a mail list that
> someone wanted select to
> select on 3000 files.  Alright, the question(Finally!):
> 		To have select() select on 3000 file descriptors,
> they must be open.  That's 3000 open
> 		files.  Will select be ultra slow trying to select
> on 3000 file descriptors?  Also,
> 		what is the clarification on the kernel doing a
> sequential search through the open
> 		file descriptors?

	Using 'select' on 3,000 file descriptors is not a problem. I have used
'poll' on 12,000 file descriptors with no problems at all. Performance is
not exactly stellar (you can use threads to improve it) but it's quite good.

	DS

