Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129096AbQKARM5>; Wed, 1 Nov 2000 12:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129330AbQKARMr>; Wed, 1 Nov 2000 12:12:47 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:42996 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129096AbQKARMf>; Wed, 1 Nov 2000 12:12:35 -0500
Date: Wed, 1 Nov 2000 15:11:46 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: matthew <matthew@mattshouse.com>
cc: Jonathan George <Jonathan.George@trcinc.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.0-test10 Sluggish After Load
In-Reply-To: <Pine.LNX.4.21.0011011054150.7127-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0011011509490.11112-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, matthew wrote:

> The "thrashing" has been going on for roughly 10 hours now.  Is
> there a point at which I can expect it to stop?  The load
> average is at 441 (down from > 700 last night), and the stress
> program was killed at 1:00AM CST last night.  This (obviously)
> isn't an important machine so if you want me to ride it out I
> will.

Interpolating from those load figures, you'll probably have
to wait for 5 to 10 more hours ;)

It looks like you were testing the machine /very/ close to
the thrashing point and the garbage collection afterwards
pushed it right over the edge.

One possible solution to speed things up would be to send
-SIGSTOP to 90% of the oracle processes and wake them up
again slowly later on...  (this is basically what thrashing
control in an OS does, suspend processes and wake them up
again later)

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
