Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264111AbRFLAi2>; Mon, 11 Jun 2001 20:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264112AbRFLAiS>; Mon, 11 Jun 2001 20:38:18 -0400
Received: from [216.151.155.121] ([216.151.155.121]:6419 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S264111AbRFLAiL>; Mon, 11 Jun 2001 20:38:11 -0400
To: Matt Nelson <mnelson@dynatec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any limitations on bigmem usage?
In-Reply-To: <3B255FC1.90501@dynatec.com>
	<m37kyitu78.fsf@belphigor.mcnaught.org>
From: Doug McNaught <doug@wireboard.com>
Date: 11 Jun 2001 20:38:09 -0400
In-Reply-To: Doug McNaught's message of "11 Jun 2001 20:31:23 -0400"
Message-ID: <m33d96ttvy.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught <doug@wireboard.com> writes:

> Matt Nelson <mnelson@dynatec.com> writes:
> 
> > I am about to embark on a data processing software project that
> > will require a LOT of memory (about, ohhh, 6GB or so), and I was
> > wondering if there are any limitations to how one can use very
> > large chunks of memory under Linux. Specifically, is there
> > anything to prevent me from malloc()ing 6GB of memory, then
> > accessing that memory as I would any other buffer?  FYI, the
> > application will be buffering a stream of data, then performing a
> > variety of calculations on large blocks of data at a time, before
> > writing it out to a socket.
> 
> Pointers on IA32 are still 32 bits, so (as I understand it) each
> process can address a maximum of 4GB.  You would have to allocate
> multiple chunks (in shared memory or mmap()ed files, so they're
> persistent) and map them in and out as needed (which could get hairy).

Sorry to followup to myself, but I just had another thought--if you
can split your task up into multiple processe such that no process
needs to address more than 4GB, an IA32 machine will work fine.  It
will probably still take more programming work than the naive approach
(malloc() huge chink, use it) that you could use on a 64-bit
machine...

-Doug
-- 
The rain man gave me two cures; he said jump right in,
The first was Texas medicine--the second was just railroad gin,
And like a fool I mixed them, and it strangled up my mind,
Now people just get uglier, and I got no sense of time...          --Dylan
