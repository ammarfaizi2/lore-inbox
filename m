Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265721AbRF3KdD>; Sat, 30 Jun 2001 06:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbRF3Kcy>; Sat, 30 Jun 2001 06:32:54 -0400
Received: from vagabond.btnet.cz ([62.80.85.77]:11648 "EHLO vagabond.btnet.cz")
	by vger.kernel.org with ESMTP id <S265721AbRF3Kcq>;
	Sat, 30 Jun 2001 06:32:46 -0400
Date: Sat, 30 Jun 2001 12:32:47 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [Re: Process creating]
Message-ID: <20010630123247.C898@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010627063513.18205.qmail@nw171.netaddress.usa.net>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 12:35:13AM -0600, Blesson Paul wrote:
> 1: P1 and P2 have different physical areas of memory. This is how 
> protection works.
> 
> 2: Why do they need to share the same memory? You can have your second
> process
> communicate with your first process through IPC.
> 
> 3: Linux supports threading if you include the thread library, and use the 
> appropriate
> threading process calls.
> 
> Another thing you can do is have a common space on the hard drive. It's not 
> as fast as RAM,
> but it's one solution.

As to 1 (and 3), if you clone the processes (using the __clone - advanced
version of fork), you can specify what the processes should share. Including
memory. Thus you can also have threads (that share everything but stack) even
without a thread library (libpthread actualy does just that, but it has some
conveniece stuff like locks).

As of 2, avoid using ipc, especialy the sysv one - it's rather kind
of crap (IMHO).

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
