Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbRL2TkK>; Sat, 29 Dec 2001 14:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285366AbRL2TkA>; Sat, 29 Dec 2001 14:40:00 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:22780 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S285369AbRL2Tjt>; Sat, 29 Dec 2001 14:39:49 -0500
Date: Sat, 29 Dec 2001 14:43:14 -0500
To: Jens Axboe <axboe@suse.de>
Cc: rwhron@earthlink.net, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011229144314.A17468@earthlink.net>
In-Reply-To: <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de> <20011227140723.A4713@earthlink.net> <20011228124037.K2973@suse.de> <20011228091401.A15569@earthlink.net> <20011228153022.D1248@suse.de> <20011229014248.A17257@earthlink.net> <20011229183315.E1821@suse.de> <20011229184837.F1821@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011229184837.F1821@suse.de>; from axboe@suse.de on Sat, Dec 29, 2001 at 06:48:37PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 06:48:37PM +0100, Jens Axboe wrote:
> Ah I think I got it -- appears to be down to no rechecking for empty
> queue after a potential queue_lock droppage (busy I/O, no request left
> get_request returns NULL, drop lock and run get_request_wait). This
> explains the get_request_wait deadlock, compiling right now...
> 
> -- 
> Jens Axboe

Two thumbs up!!  With your ll_rw_blk.c and elevator.c patches,
2.5.2-pre3 completes dbench 32, 128.  

I'm running a more complete battery of tests and will let you know
if there are any unusual results.

Thanks!

-- 
Randy Hron

