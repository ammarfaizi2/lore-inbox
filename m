Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282799AbRK0Eqr>; Mon, 26 Nov 2001 23:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282796AbRK0Eqh>; Mon, 26 Nov 2001 23:46:37 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18189 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282798AbRK0EqY>; Mon, 26 Nov 2001 23:46:24 -0500
Message-ID: <3C031A60.10527E6A@zip.com.au>
Date: Mon, 26 Nov 2001 20:45:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Nathan G. Grennan" <ngrennan@okcforum.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <E168U3m-00077F-00@the-village.bc.nu> <Pine.LNX.4.33L.0111262156140.4079-100000@imladris.surriel.com> <3C02E009.7C1F17C6@zip.com.au>,
		<3C02E009.7C1F17C6@zip.com.au> <20011126203856.D26219@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Mon, Nov 26, 2001 at 04:36:25PM -0800, Andrew Morton wrote:
> > The patch I sent puts read requests near the head of the request
> > queue, and to hell with aggregate throughput.  It's tunable with
> > `elvtune -b'.  And it fixes it.
> 
> for i in `seq 9`; do elvtune -b $i /dev/hda; done
> 
> -b doesn't seem to change the "max_bomb_segments".  Does your patch fix this?
> 

Yes, it does.

Presumably, once upon a time, max_bomb_segments actually did
something.  But it's a complete no-op at present, so I co-opted it.

Nice name, but I'd prefer max_cluster_bombs.

-
