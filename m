Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSG3AAa>; Mon, 29 Jul 2002 20:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318153AbSG3AAa>; Mon, 29 Jul 2002 20:00:30 -0400
Received: from [195.223.140.120] ([195.223.140.120]:45344 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318045AbSG3AA3>; Mon, 29 Jul 2002 20:00:29 -0400
Date: Tue, 30 Jul 2002 02:04:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
Message-ID: <20020730000428.GN1201@dualathlon.random>
References: <20020729234558.GM1201@dualathlon.random> <Pine.LNX.4.44L.0207292051040.3086-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0207292051040.3086-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 08:51:51PM -0300, Rik van Riel wrote:
> On Tue, 30 Jul 2002, Andrea Arcangeli wrote:
> 
> > and the new one had a bug too :). Please merge the fix I posted to l-k
> > too thanks.
> 
> Judging from the patch the code seems incredibly subtle and
> I'd be amazed if it doesn't break again every few weeks...

what's subtle exactly? I found the SD_MAJOR >>4, << 8 >> 8 16 devnum <<
4 in sd.c subtle, this doesn't look subtle to me. The code simply avoids
to rebalance the current idle cpu if the sibling isn't idle too and it
tries to idle reschedule another idle package (with both sibling idle)
instead. The coding is in coherent style with the rest of the o1
scheduler as far I can tell.

Andrea
