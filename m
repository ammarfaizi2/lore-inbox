Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271560AbRHUFOw>; Tue, 21 Aug 2001 01:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271563AbRHUFOm>; Tue, 21 Aug 2001 01:14:42 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19976 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271560AbRHUFOY>;
	Tue, 21 Aug 2001 01:14:24 -0400
Date: Tue, 21 Aug 2001 02:14:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <Pine.LNX.4.33.0108210629020.672-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33L.0108210208320.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Mike Galbraith wrote:
> On Mon, 20 Aug 2001, Daniel Phillips wrote:

> > What made you think of trying the higher activation threshold? ;-)
>
> Well :)) there I sat daydreaming, imagining myself as a bonnie page
> running around queues, got dizzy and finally just changed the little
> spot that kept attracting my eyeballs.. a hunch.

And a good hunch.  There is NO fundamental difference between
used-once vs. used-twice or used-twice vs. used-thrice.  It's
one big gray area of pages further or closer to eviction.

The solution to making a system which is resistant to scanning,
yet allows the streaming IO to evict the least used part of the
currently active pages (to replace old data) is to use a better
page aging tactic.

If you don't believe me, try streaming IO on Linux 2.0 for a
try, or grab my patch to introduce tunable page aging on
2.4.8-ac7+ and try it. ;)

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

