Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272588AbRIPRfZ>; Sun, 16 Sep 2001 13:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272590AbRIPRfP>; Sun, 16 Sep 2001 13:35:15 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24331 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272588AbRIPRe5>;
	Sun, 16 Sep 2001 13:34:57 -0400
Date: Sun, 16 Sep 2001 14:34:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@caldera.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre7aa1
In-Reply-To: <20010916192316.A13248@athlon.random>
Message-ID: <Pine.LNX.4.33L.0109161433530.9536-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Andrea Arcangeli wrote:

> However the issue with keventd and the fact we can get away with a
> single per-cpu counter increase in the scheduler fast path made us to
> think it's cleaner to just spend such cycle for each schedule rather
> than having yet another 8k per cpu wasted and longer taskslists (a
> local cpu increase is cheaper than a conditional jump).

So why don't we put the test+branch inside keventd ?

wakeup_krcud(void)
{
	krcud_wanted = 1;
	wakeup(&keventd);
}

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

