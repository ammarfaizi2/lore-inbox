Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266397AbUGBDEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUGBDEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 23:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266423AbUGBDEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 23:04:13 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:57774 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266397AbUGBDEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 23:04:08 -0400
Message-ID: <40E4D08B.1070608@kolivas.org>
Date: Fri, 02 Jul 2004 13:03:39 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, mpm@selenic.com, paul@linuxaudiosystems.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
References: <200406301341.i5UDfkKX010518@localhost.localdomain> <20040701180356.GI5414@waste.org> <20040701181401.GB21066@holomorphy.com> <20040701154554.30063e97.akpm@osdl.org> <20040702004538.GF21066@holomorphy.com>
In-Reply-To: <20040702004538.GF21066@holomorphy.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

William Lee Irwin III wrote:
| On Thu, Jul 01, 2004 at 03:45:54PM -0700, Andrew Morton wrote:
|
|>In fairness, the CPU scheduler has been spinning like a top for a
|>couple of years, and it still ain't settled.
|>That's just the one in Linus's tree, let alone the umpteen rewrites
|>which are floating about.
|
|
| I've not seen much deep material there. Policy tweaks seem to be
| what's gone on in mainline, and frankly most of the purported rewrites
| are just that. I guess the ones that nuked the duelling queue silliness
| are trying qualify but even they're leaving the load balancer untouched
| and are carrying over large fractions of their predecessors unaltered.
| The stuff that's gone around looks minor. It's not like they're teaching
| sched.c to play cpu tetris for gang scheduling or Kalman filtering
| profiling feedback to stripe tasks using different cpu resources across
| SMT siblings or playing graph games to meet RT deadlines, so it doesn't
| look like very much at all is going on to me.

My impetus for doing a policy rewrite was the recurring complaint that
the 2.6 scheduler is currently too complicated for even basic
scheduling. I see no point in trying to implement other changes until
the framework for normal policies is in place that can be built on. I
don't see even the policy rewrites as being appropriate for 2.6, let
alone anything fancier. If we have something in place that more people
than not agree is satisfactory for normal scheduling, then more can be
added for 2.7+ development.

Con

| It's pretty obvious why everyone and their brother is grinding out
| purported scheduler rewrites: the code is self-contained, however,
| nothing interesting is coming of all this. Never been for have so many
| patches been written against the same file, accomplishing so little.
|
| -- wli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA5NCKZUg7+tp6mRURAj/JAJ4qJzKxXWCUOT+LDBoGs0MEMi21owCfZqGo
S8scT9Ro6DbvumUt060ctOU=
=6I3d
-----END PGP SIGNATURE-----
