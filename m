Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280871AbRKBXOP>; Fri, 2 Nov 2001 18:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280872AbRKBXOF>; Fri, 2 Nov 2001 18:14:05 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:20670 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S280871AbRKBXN4>; Fri, 2 Nov 2001 18:13:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Sat, 3 Nov 2001 00:15:02 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <9rv2nc$kgi$1@penguin.transmeta.com> <3BE3215A.9000302@google.com>
In-Reply-To: <3BE3215A.9000302@google.com>
Cc: Ben Smith <ben@google.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011102231355Z16864-4784+496@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 2, 2001 11:42 pm, Ben Smith wrote:
> As another note, I've re-written my test application to use madvise 
> instead of mlock, on a suggestion from Andrea. It also doesn't work. For 
> 2.4.13, after running for a while, my test app hangs, using one CPU, and 
> kswapd consumes the other CPU. I was eventually able to kill my test app.

OK, while there may be room for debate over whether the mlock problem is a 
bug there's no question with madvise.  The program still doesn't work if you 
replace the mlocks with madvises (except for the mlock that's used to 
estimate memory size).

--
Daniel

