Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277258AbRJQVp7>; Wed, 17 Oct 2001 17:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277260AbRJQVpu>; Wed, 17 Oct 2001 17:45:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58886 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277258AbRJQVpm>; Wed, 17 Oct 2001 17:45:42 -0400
Date: Wed, 17 Oct 2001 14:45:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <chris@scary.beasts.org>
cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Gortmaker <p_gortmaker@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Making diff(1) of linux kernels faster
In-Reply-To: <Pine.LNX.4.33.0110172220230.2072-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.33.0110171444210.1537-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Oct 2001 chris@scary.beasts.org wrote:
>
> Do the -ac kernels have the directory in pagecache patch? If not, it could
> explain why the -ac kernel performed _much_ better for the
> creat()/stat()/unlink() tests in bonnie++.

I think that's because bforget() got disabled during the initial
buffers-in-pacgecache work, and I forgot to re-enable it again. I'll make
a 13pre4, if you want to test.

		Linus

