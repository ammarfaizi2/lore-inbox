Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136596AbREAIzS>; Tue, 1 May 2001 04:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136597AbREAIzA>; Tue, 1 May 2001 04:55:00 -0400
Received: from chiara.elte.hu ([157.181.150.200]:31507 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S136596AbREAIyy>;
	Tue, 1 May 2001 04:54:54 -0400
Date: Tue, 1 May 2001 10:53:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <3AEC8562.887CFA72@chromium.com>
Message-ID: <Pine.LNX.4.33.0105011047540.4266-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hm, another X15 caching artifact i noticed: i've changed the index.html
file, and while X15 was still serving the old copy, TUX served the new
file immediately.

its cache is apparently not coherent with actual VFS contents. (ie. it's a
read-once cache apparently?) TUX has some (occasionally significant)
overhead due to non-cached VFS-lookups.

	Ingo

