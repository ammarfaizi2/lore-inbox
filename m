Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282969AbRLIE3f>; Sat, 8 Dec 2001 23:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282970AbRLIE30>; Sat, 8 Dec 2001 23:29:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8977 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282969AbRLIE3G>; Sat, 8 Dec 2001 23:29:06 -0500
Date: Sat, 8 Dec 2001 20:22:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <Andries.Brouwer@cwi.nl>
cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <viro@math.psu.edu>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <UTC200112081726.RAA247456.aeb@cwi.nl>
Message-ID: <Pine.LNX.4.33.0112082021190.1457-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Dec 2001 Andries.Brouwer@cwi.nl wrote:
>
>     Oh, well. It _is_ going to be quite painful to switch things around.
>
> I don't understand at all. It is not painful at all.
> Things are completely straightforward.
>
> A kdev_t is a pointer to all information needed, nowhere a lookup,
> except at open time.

No.

I refuse to have the same structure for block devices and character
devices. We already know that they are different.

Which means that I _will_ rename the thing.

Which means that the patch will be straightforward, but painful.

> I am sure also Al will tell you that there is no problem.

To me, touching a few hundred files, even if it's almost a
search-and-replace operation is always painful. Much more painful than
touching just one subsystem..

		Linus

