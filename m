Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131060AbQL1SfG>; Thu, 28 Dec 2000 13:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131071AbQL1Se4>; Thu, 28 Dec 2000 13:34:56 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:47860 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131060AbQL1Seu>; Thu, 28 Dec 2000 13:34:50 -0500
Date: Thu, 28 Dec 2000 16:02:49 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dan Aloni <karrde@callisto.yi.org>, Zlatko Calusic <zlatko@iskon.hr>,
        "Marco d'Itri" <md@Linux.IT>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.10.10012280946020.12064-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012281552390.14052-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Linus Torvalds wrote:
> On Thu, 28 Dec 2000, Rik van Riel wrote:
> > 
> > I've made a small debugging patch that simply checks
> > for this illegal state in add_page_to_active_list and
> > add_page_to_inactive_dirty_list.
> 
> I bet it won't catch the real bad guy, which almost certainly is
> the "remove_from_swap_cache()" thing (it should do a
> ClearPageDirty() before it removes it from the swapper_inode
> mapping).

Ohhh indeed. This is a very likely candidate which is
trivial to fix.

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
