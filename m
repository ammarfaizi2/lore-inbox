Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282792AbRK0Ej1>; Mon, 26 Nov 2001 23:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282799AbRK0EjI>; Mon, 26 Nov 2001 23:39:08 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13553
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282792AbRK0EjC>; Mon, 26 Nov 2001 23:39:02 -0500
Date: Mon, 26 Nov 2001 20:38:56 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Nathan G. Grennan" <ngrennan@okcforum.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011126203856.D26219@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Nathan G. Grennan" <ngrennan@okcforum.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E168U3m-00077F-00@the-village.bc.nu> <Pine.LNX.4.33L.0111262156140.4079-100000@imladris.surriel.com> <3C02E009.7C1F17C6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C02E009.7C1F17C6@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 04:36:25PM -0800, Andrew Morton wrote:
> The patch I sent puts read requests near the head of the request
> queue, and to hell with aggregate throughput.  It's tunable with
> `elvtune -b'.  And it fixes it.

for i in `seq 9`; do elvtune -b $i /dev/hda; done

-b doesn't seem to change the "max_bomb_segments".  Does your patch fix this?

Tested on 2.4.15-pre1.

MF
