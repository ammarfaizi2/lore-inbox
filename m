Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131348AbQJ1WHw>; Sat, 28 Oct 2000 18:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbQJ1WHn>; Sat, 28 Oct 2000 18:07:43 -0400
Received: from brutus.conectiva.com.br ([200.250.58.146]:15607 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131348AbQJ1WHc>; Sat, 28 Oct 2000 18:07:32 -0400
Date: Sat, 28 Oct 2000 20:07:13 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Mauelshagen@sistina.com
cc: mhe@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: LVM snapshotting broken?
In-Reply-To: <20001028200244.A19767@srv.t-online.de>
Message-ID: <Pine.LNX.4.21.0010282005530.4224-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2000, Heinz J. Mauelshagen wrote:

> > OK, good. I guess that means that the lvmutils (even the
> > patched version in the RPM) are heavily broken ...
> 
> As i mentioned before: i wasn't able to reproduce your problem on any of
> my systems. It work just fine with 0.8final and in 0.9 as weel.
> 
> Did anybody else beside Rik face a problem with snapshots _not_
> referring to the original logical volume they where created for?

There's a missing item in the _data structure declaration_
in the header file that prevents userspace from passing
the right LV argument to the kernel, resulting in the kernel
always making a snapshot of LV #0.

You may have written LVM, but that doesn't excuse you from
checking your facts ;)

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
