Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136311AbRD1BfM>; Fri, 27 Apr 2001 21:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136314AbRD1BfC>; Fri, 27 Apr 2001 21:35:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35345 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136311AbRD1Bes>; Fri, 27 Apr 2001 21:34:48 -0400
Date: Fri, 27 Apr 2001 18:34:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for fixing get_super() races
In-Reply-To: <Pine.GSO.4.21.0104272117440.21109-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0104271833280.1120-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Apr 2001, Alexander Viro wrote:
> 
> Fine with me. Actually in _all_ cases execept cdrom.c it's preceded by
> either sync_dev() or fsync_dev(). What do you think about pulling that
> into the same function?

I'd actually prefer not. I don't think it makes sense from a conceptual
standpoint, and I think drivers could validly say "syncing this device at
this point is _wrong_".

		Linus

