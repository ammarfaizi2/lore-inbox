Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132501AbRDRSWL>; Wed, 18 Apr 2001 14:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRDRSWC>; Wed, 18 Apr 2001 14:22:02 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:37807 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S132501AbRDRSVs>; Wed, 18 Apr 2001 14:21:48 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Laurent Chavet" <lchavet@av.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Is there a way to turn file caching off ?
Date: Wed, 18 Apr 2001 11:21:46 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKOEPOOGAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
In-Reply-To: <3ADD4E61.A2A9CE9@av.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	It's insignificant. If we assume the caching isn't helping, that means each
'non-recent' page access results in an IO operation. The cost of an IO
operation (a millisecond or more) is so much in comparison to the cost of a
primary cache miss (less than a microsecond) that avoiding a ferw primary
cache misses per IO isn't likely to make any measurable difference.

	DS

-----Original Message-----
From: lchavet@smo.av.com [mailto:lchavet@smo.av.com]On Behalf Of Laurent
Chavet
Sent: Wednesday, April 18, 2001 1:21 AM
To: David Schwartz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to turn file caching off ?


Since the speed already drops before even writing to disk, I was thinking
that for "large memory" the management of the tree that contain which pages
are cached becomes high (since the tree is large and probably doesn't fit in
primary cache).
So if you can limit the size of what you cache, you limit the size of the
tree -> you limit the time spent in the tree.
(by the way I'm using both 2.4.2 that come with RedHat 7.1 and 2.4.4 pre 3
and see the same thing).
Laurent

David Schwartz wrote:
> Is there a way to turn file caching off, or at least limit its size ?
>
> Thanks,
>
> Laurent Chavet
        What benefit do you think you would get by limiting its size? All
that
would do is ensure you hit the cache thrashing point sooner.
        DS
--
Laurent Chavet


