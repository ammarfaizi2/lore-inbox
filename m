Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbREUHX2>; Mon, 21 May 2001 03:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261821AbREUHXS>; Mon, 21 May 2001 03:23:18 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:10632 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261786AbREUHXH>; Mon, 21 May 2001 03:23:07 -0400
Message-ID: <3B08C15E.264AE074@uow.edu.au>
Date: Mon, 21 May 2001 17:18:54 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Vojta <vojta@ipex.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c905C-TX [Fast Etherlink] problem ...
In-Reply-To: <20010521090946.D769@ipex.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Vojta wrote:
> 
> Hi,
>   I have this card in intranet server and I'm very confused about very often
> message in log like this:
> 
> eth0: Transmit error, Tx status register 82.

This is a `transamit reclaim' error.  It is almost always
caused by this host being in half-duplex mode, and another
host on the network being in full-duplex mode.

It's a fairly common problem - I think I'll special-case
the error message...

Yu should check your network thoroughly, decide whether
you're supposed to be running half- or full-duplex.  Review
the vortex archives at http://www.scyld.com/mailman/listinfo/vortex

If that yields no joy, please send a report as described
in the final section of http://www.uow.edu.au/~andrewm/linux/vortex.txt
to vortex@scyld.com and we'll work on it.

Thanks.

-
