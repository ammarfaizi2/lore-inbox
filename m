Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTFDTnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbTFDTnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:43:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28935 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263983AbTFDTnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:43:03 -0400
Date: Wed, 4 Jun 2003 12:56:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "P. Benie" <pjb1008@eng.cam.ac.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <Pine.HPX.4.33L.0306041937290.18475-100000@punch.eng.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0306041255060.15174-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jun 2003, P. Benie wrote:
> 
> The problem isn't to do with large writes. It's to do with any sequence of
> writes that fills up the receive buffer, which is only 4K for N_TTY. If
> the receiving program is suspended, the buffer will fill sooner or later.

Well, even then we could just drop the "write_atomic" lock. 

The thing is, I don't know what the tty atomicity guarantees are. I know 
what they are for pipes (quite reasonable), but tty's? 

		Linus

