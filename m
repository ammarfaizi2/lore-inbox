Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRHSRgR>; Sun, 19 Aug 2001 13:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268199AbRHSRgH>; Sun, 19 Aug 2001 13:36:07 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:54793 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S267534AbRHSRfx>;
	Sun, 19 Aug 2001 13:35:53 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 19 Aug 2001 17:32:42 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lot7q$pmg$4@abraham.cs.berkeley.edu>
In-Reply-To: <20010817171834.A24850@thunk.org> <NOEJJDACGOHCKNCOGFOMKEFFDEAA.davids@webmaster.com> <20010819111357.A3504@thunk.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998242362 26320 128.32.45.153 (19 Aug 2001 17:32:42 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 19 Aug 2001 17:32:42 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso  wrote:
>On Fri, Aug 17, 2001 at 03:05:39PM -0700, David Schwartz wrote:
>> 	This is a non-issue providing the entropy pool code correctly
>> estimates the amount of entropy. The Linux entropy code is written
>> so that there is no harm from putting fully known or partially known
>> numbers into the pool provided that the pool does not overestimate
>> the amount of entropy in those numbers.
>
>The problem is that by being able to perfectly observe packets on the
>LAN, you know a lot more about the numbers that are going in, and it's
>therefore extremely likely that the entropy estimate will be
>overestimated.  

Right.  Therefore, it seems to me that the correct thing to do is to
add network timings into the pool using an entropy estimate of zero.
