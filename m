Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274131AbRIXS3t>; Mon, 24 Sep 2001 14:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274143AbRIXS33>; Mon, 24 Sep 2001 14:29:29 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19217 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S274131AbRIXS3W>; Mon, 24 Sep 2001 14:29:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: Linux VM design
Date: Mon, 24 Sep 2001 20:37:17 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com> <20010922105332Z16449-2757+1233@humbolt.nl.linux.org> <6514162334.20010924123631@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <6514162334.20010924123631@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010924182948Z16175-2757+1593@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 24, 2001 11:36 am, VDA wrote:
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> DP> The arguments in support of aging over LRU that I'm aware of are:
> 
> DP>   - incrementing an age is more efficient than resetting several LRU 
> DP>     list links
> DP>   - also captures some frequency-of-use information
> 
> Of what use this info can be? If one page is accessed 100 times/second
> and other one once in 10 seconds, they both have to stay in RAM.
> VM should take 'time since last access' into account whan deciding
> which page to swap out, not how often it was referenced.

You might want to have a look at this:

   http://archi.snu.ac.kr/jhkim/seminar/96-004.ps
   (lrfu algorithm)

To tell the truth, I don't really see why the frequency information is all
that useful either.  Rik suggested it's good for streaming IO but we already 
have effective means of dealing with that that don't rely on any frequency 
information.

So the list of reasons why aging is good is looking really short.

--
Daniel
