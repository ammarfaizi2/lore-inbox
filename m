Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbREZP1p>; Sat, 26 May 2001 11:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbREZP1g>; Sat, 26 May 2001 11:27:36 -0400
Received: from [195.223.140.120] ([195.223.140.120]:27408 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261408AbREZP10>; Sat, 26 May 2001 11:27:26 -0400
Date: Sat, 26 May 2001 17:24:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526172444.A9634@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0105260806430.3648-100000@penguin.transmeta.com> <Pine.LNX.4.21.0105261217080.30264-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105261217080.30264-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 26, 2001 at 12:18:07PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 12:18:07PM -0300, Rik van Riel wrote:
> It's the changes to __alloc_pages(), where we don't loop forever
> but fail the allocation.

__alloc_pages() should definitely not to loop forever but it should fail
the allocation instead. If it doesn't right now that is yet another bug,
at least with the 2.4 memory management design where we don't know if
there is memory available or not when we do the allocation. I'd really
appreciate if you could re-post this strictly necessary localized fix, I
will definitely agree about that one.

Andrea
