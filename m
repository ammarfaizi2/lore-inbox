Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317999AbSFSU2U>; Wed, 19 Jun 2002 16:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318001AbSFSU2T>; Wed, 19 Jun 2002 16:28:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54289 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317999AbSFSU2S>; Wed, 19 Jun 2002 16:28:18 -0400
Date: Wed, 19 Jun 2002 13:24:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
cc: Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
       Dave Jones <davej@suse.de>, Daniel Phillips <phillips@bonn-fries.net>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       <rwhron@earthlink.net>
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
In-Reply-To: <Pine.LNX.4.44.0206191310590.4292-100000@loke.as.arizona.edu>
Message-ID: <Pine.LNX.4.33.0206191322480.2638-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Craig Kulesa wrote:
> 
> I'll try a more varied set of tests tonight, with cpu usage tabulated.

Please do a few non-swap tests too. 

Swapping is the thing that rmap is supposed to _help_, so improvements in
that area are good (and had better happen!), but if you're only looking at
the swap performance, you're ignoring the known problems with rmap, ie the
cases where non-rmap kernels do really well.

Comparing one but not the other doesn't give a very balanced picture..

		Linus

