Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273864AbRIRF7g>; Tue, 18 Sep 2001 01:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273865AbRIRF70>; Tue, 18 Sep 2001 01:59:26 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20024 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273864AbRIRF7K>; Tue, 18 Sep 2001 01:59:10 -0400
Date: Tue, 18 Sep 2001 07:59:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918075927.I698@athlon.random>
In-Reply-To: <20010918073248.G698@athlon.random> <Pine.LNX.4.21.0109180111550.7152-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109180111550.7152-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Sep 18, 2001 at 01:14:36AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 01:14:36AM -0300, Marcelo Tosatti wrote:
> Note that in 2.4 we scan pte's even if there is no free pages
> shortage, while in 2.2 we only scan pte's if there is a free page
> shortage.

That was most certainly a problem which is now fixed. Mainly the
preallication of swap was a waste. But I think there was a kind of
physical (not pte) overaging too that forbidden the vm to react
properly.

I believe when the storm of swap_out startups it won't matter any longer
what we aged and whatever pte scanning we did previously. At least with
the current swap_out.

Andrea
