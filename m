Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263957AbRFRNnu>; Mon, 18 Jun 2001 09:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263963AbRFRNnk>; Mon, 18 Jun 2001 09:43:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19474 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S263957AbRFRNnW>;
	Mon, 18 Jun 2001 09:43:22 -0400
Date: Mon, 18 Jun 2001 10:43:14 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: German Gomez Garcia <german@piraos.com>,
        Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
In-Reply-To: <20010618143559.A23006@athlon.random>
Message-ID: <Pine.LNX.4.21.0106181041470.2056-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Andrea Arcangeli wrote:

> either apply this patch to 2.4.5ac15:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa3/00_fix-unusable-vm-on-alpha-1

That one has already been fixed in -pre3 and I think also
in -ac14+ kernels (haven't verified the -ac kernels, though).

The "bug" exists because of a change in refill_inactive(),
which is now a lot closer to being balanced. It's not a bug,
but with the way the statistics are generated it sure look
funny ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

