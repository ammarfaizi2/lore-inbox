Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310162AbSCFUhD>; Wed, 6 Mar 2002 15:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293709AbSCFUgz>; Wed, 6 Mar 2002 15:36:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15887 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310162AbSCFUgo>; Wed, 6 Mar 2002 15:36:44 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
Date: Wed, 6 Mar 2002 20:36:14 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a65uju$be7$1@penguin.transmeta.com>
In-Reply-To: <3C85F872.7050306@evision-ventures.com> <Pine.LNX.3.96.1020306105428.386A-100000@gatekeeper.tmr.com>
X-Trace: palladium.transmeta.com 1015446983 7707 127.0.0.1 (6 Mar 2002 20:36:23 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Mar 2002 20:36:23 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.96.1020306105428.386A-100000@gatekeeper.tmr.com>,
Bill Davidsen  <davidsen@tmr.com> wrote:
>
>  Can't disagree, I never understood how people who can understand
>inheritance can be fuddled by pointers to functions.

One thing I'd love to see in C is default values for structure members
in initializers. 

Pretty much everything else is trivially done with structures and
function pointers - once you allocate things dynamically you can (and
should) trivially and logically just make the allocator initialize the
needed fields too.  But for static allocations and static initializers
you cannot cleanly do the same thing - you have to add explicit code
that knows about each statically allocated entry. 

That's basically the only piece of object constructors that I consider
really _useful_, with the rest just being syntactic fluff.

		Linus
