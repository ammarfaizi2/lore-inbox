Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267919AbTAMOGZ>; Mon, 13 Jan 2003 09:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267927AbTAMOGZ>; Mon, 13 Jan 2003 09:06:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10136
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267919AbTAMOGY>; Mon, 13 Jan 2003 09:06:24 -0500
Subject: Re: Linux 2.4.21pre3-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jean-Daniel Pauget <jd@disjunkt.com>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030112222243.17657C-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030112222243.17657C-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042470092.18624.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 15:01:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 03:33, Bill Davidsen wrote:
> There are several possibilities, but I would suspect you have memory which
> is just marginal, and with some combination of access patterns you trigger
> a sig 11 problem. I have the same board, with 72 bit ECC capable memory,
> and I'm running all of the BIOS speed options (section 4.4 of the manual)
> set at default, rather than tuning for any extra bit of performance.

I'm seeing enough other -ac specific errors to be fairly sure its not just
hardware in the current -ac tree case. I don't know what the common factor
is yet - it 'works for me' which makes it hard to pin down

Guess #1 is reverting mm/shmem.c. Guess #2 is reverting the buffer cache
changes. Guess #3 is new IDE + highmem and Guess #4 is quota related (are
people seeing the problem with quota disabled ?)

