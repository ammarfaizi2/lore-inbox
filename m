Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264645AbRFPSgI>; Sat, 16 Jun 2001 14:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbRFPSf6>; Sat, 16 Jun 2001 14:35:58 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:57608
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S264645AbRFPSfy>;
	Sat, 16 Jun 2001 14:35:54 -0400
Subject: Re: Buffer management - interesting idea
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: Ivan Schreter <is@zapwerk.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3B29D048.4E19D545@idb.hist.no>
In-Reply-To: <01060613422800.07218@linux>  <3B29D048.4E19D545@idb.hist.no>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 16 Jun 2001 11:35:25 -0700
Message-Id: <992716525.22810.2.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 2001 11:07:20 +0200, Helge Hafting wrote:
> The "resistance to scanning" seemed interesting, maybe one-time
> activities like a "find" run or big cat/dd will have less impact with
> this.

It should also be good for streaming file use.  It gives a natural way
of detecting when you should be doing drop-behind (things fall out of
the fifo without ever making it into the LRU); doubly nice because it
works for both reads and writes without needing to treat them
differently.  It's also nice that it gives a natural interpretation to
the various madvise() flags.

    J

