Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRAQHcc>; Wed, 17 Jan 2001 02:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbRAQHcW>; Wed, 17 Jan 2001 02:32:22 -0500
Received: from clavin.efn.org ([206.163.176.10]:58833 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S129792AbRAQHcS>;
	Wed, 17 Jan 2001 02:32:18 -0500
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14949.19028.404458.318735@tzadkiel.efn.org>
Date: Tue, 16 Jan 2001 23:31:32 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <943fm9$pjq$1@post.home.lunix>
In-Reply-To: <UTC200101161350.OAA141869.aeb@ark.cwi.nl>
	<943fm9$pjq$1@post.home.lunix>
X-Mailer: VM 6.90 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ton Hospel writes:
 > In article <UTC200101161350.OAA141869.aeb@ark.cwi.nl>,
 > 	Andries.Brouwer@cwi.nl writes:
 > > I am afraid I have missed most earlier messages in this thread.
 > > However, let me remark that the problem of assigning a
 > > file descriptor is the one that is usually described by
 > > "priority queue". The version of Peter van Emde Boas takes
 > > time O(loglog N) for both open() and close().
 > > Of course this is not meant to suggest that we use it.
 > > 
 > Fascinating ! But how is this possible ? What stops me from
 > using this algorithm from entering N values and extracting 
 > them again in order and so end up with a O(N*log log N)
 > sorting algorithm ? (which would be better than log N! ~ N*logN)
 > 
 > (at least the web pages I found about this seem to suggest you
 > can use this on any set with a full order relation)

How do you know how to extract the items in order, unless you've already
sorted them independently from placing them in this data structure?

Besides, there are plenty of sorting algorithms that work only on
specific kinds of data sets that are better than the O(n log n) bound
for generalized sorting.  For example, there's the O(n) "mailbox sort".
You have an unordered array u of m integers, each in the range 1..n;
allocate an array s of n integers initialized to all zeros, and for i in
1..m increment s[u[i]].  Then for j in 1..n print j s[j] times.  If n is
of reasonable size then you can sort that list of integers in O(m) time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
