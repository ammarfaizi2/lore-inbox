Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbTCWFSQ>; Sun, 23 Mar 2003 00:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbTCWFSQ>; Sun, 23 Mar 2003 00:18:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35848 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262432AbTCWFSP>; Sun, 23 Mar 2003 00:18:15 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: lmbench results for 2.4 and 2.5
Date: Sun, 23 Mar 2003 05:27:51 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b5jgkn$l0s$1@penguin.transmeta.com>
References: <3E7C8B22.7020505@nortelnetworks.com>
X-Trace: palladium.transmeta.com 1048397346 11682 127.0.0.1 (23 Mar 2003 05:29:06 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 23 Mar 2003 05:29:06 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E7C8B22.7020505@nortelnetworks.com>,
Chris Friesen  <cfriesen@nortelnetworks.com> wrote:
>
>My previous testing with unix sockets prompted me to do a few lmbench runs with 
>2.4.19 and 2.5.65.  The results have me a bit concerned, as there is no area 
>where 2.5 is faster and several where it is significantly slower.

Try it with a modern library (like the one in the RH phoebe beta), and
you'll see system calls having sped up by a factor of two. Even on UP.

But there's certainly something wrong with your open/close/stat numbers.
I don't see anywhere _near_ those kinds of differences, and there are no
real SMP locking issues there either. Are you sure you're testing the
same setup?

Oh, and the TCP bandwidth thing is at least partly due to the fact that TCP
loopback does extra copies due to debugging code being enabled.

		Linus
