Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264108AbRFLAbs>; Mon, 11 Jun 2001 20:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264101AbRFLAbi>; Mon, 11 Jun 2001 20:31:38 -0400
Received: from [216.151.155.121] ([216.151.155.121]:5395 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S264103AbRFLAb3>; Mon, 11 Jun 2001 20:31:29 -0400
To: Matt Nelson <mnelson@dynatec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any limitations on bigmem usage?
In-Reply-To: <3B255FC1.90501@dynatec.com>
From: Doug McNaught <doug@wireboard.com>
Date: 11 Jun 2001 20:31:23 -0400
In-Reply-To: Matt Nelson's message of "Mon, 11 Jun 2001 17:18:09 -0700"
Message-ID: <m37kyitu78.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Nelson <mnelson@dynatec.com> writes:

> I am about to embark on a data processing software project that will require a
> LOT of memory (about, ohhh, 6GB or so), and I was wondering if there are any
> limitations to how one can use very large chunks of memory under
> Linux. Specifically, is there anything to prevent me from malloc()ing 6GB of
> memory, then accessing that memory as I would any other buffer?  FYI, the
> application
> 
> will be buffering a stream of data, then performing a variety of calculations
> on large blocks of data at a time, before writing it out to a socket.

Pointers on IA32 are still 32 bits, so (as I understand it) each
process can address a maximum of 4GB.  You would have to allocate
multiple chunks (in shared memory or mmap()ed files, so they're
persistent) and map them in and out as needed (which could get hairy).

> I've been eyeing an 8-way Intel box with gobs of memory, but if there are
> subtle issues with using that much memory, I need to know now.

Best bet is probably to buy an Alpha machine, if you don't want to
spend time working around the 4GB limitation.

-Doug
-- 
The rain man gave me two cures; he said jump right in,
The first was Texas medicine--the second was just railroad gin,
And like a fool I mixed them, and it strangled up my mind,
Now people just get uglier, and I got no sense of time...          --Dylan
