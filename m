Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265217AbRFUUwC>; Thu, 21 Jun 2001 16:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265216AbRFUUvw>; Thu, 21 Jun 2001 16:51:52 -0400
Received: from m146-mp1-cvx1b.col.ntl.com ([213.104.72.146]:38528 "EHLO
	[213.104.72.146]") by vger.kernel.org with ESMTP id <S265211AbRFUUvi>;
	Thu, 21 Jun 2001 16:51:38 -0400
To: David Flynn <Dave@keston.u-net.com>
Cc: linux kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [slightly OT] IDE problems ? or just a dead disk ?
In-Reply-To: <00f501c0f74e$defac4e0$1901a8c0@node0.idium.eu.org>
	<017601c0f75d$454c6e70$1901a8c0@node0.idium.eu.org>
From: John Fremlin <vii@users.sourceforge.net>
Date: 21 Jun 2001 21:51:27 +0100
In-Reply-To: <017601c0f75d$454c6e70$1901a8c0@node0.idium.eu.org> ("David Flynn"'s message of "Sun, 17 Jun 2001 19:42:33 +0100")
Message-ID: <m2d77x8skw.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Flynn" <Dave@keston.u-net.com> writes:


[...]
> ive done the badblock test, and compiled a list of 2302 bad blocks on this
> disk ... however, when running mke2fs -l badblocfile /dev/hdc1
> 
> i got this interesting errormessage for every one of the bad blocks :
> 
> Bad block 1006290 out of range; ignored.

That is probably because badblocks was working with badblocks of a
smaller size than that of the filesystem (i.e. probably 1024 bytes
instead of 4096 bytes, solution in this case is to divide all bad
block numbers by 4).

Well that's what happened to me today (worryingly on my newish IBM
DTLA hd).

-- 

	http://ape.n3.net
