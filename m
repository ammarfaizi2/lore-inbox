Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261265AbRELO4t>; Sat, 12 May 2001 10:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261266AbRELO4j>; Sat, 12 May 2001 10:56:39 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:30988 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261265AbRELO4g>;
	Sat, 12 May 2001 10:56:36 -0400
Date: Sat, 12 May 2001 11:56:20 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mark Hemment <markhe@veritas.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles 
In-Reply-To: <15096.22053.524498.144383@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105121155460.5468-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, David S. Miller wrote:

> So instead, you could test for the condition that prevents any
> possible forward progress, no?

	if (!order || free_shortage() > 0)
		goto try_again;

(which was the experimental patch I discussed with Marcelo)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

