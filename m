Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbQLHRdo>; Fri, 8 Dec 2000 12:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130190AbQLHRde>; Fri, 8 Dec 2000 12:33:34 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:26122 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S129557AbQLHRd2>; Fri, 8 Dec 2000 12:33:28 -0500
Date: Fri, 8 Dec 2000 18:02:57 +0100 (CET)
From: Martin Kacer <M.Kacer@sh.cvut.cz>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Linux 2.2.18pre25
In-Reply-To: <20001208012052.A23992@inspiron.random>
Message-ID: <Pine.LNX.4.30.0012081738140.7409-100000@duck.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Alan Cox wrote:

# Ok we believe the VM crash looping printing error messages is now fixed.
# Marcelo finally figured it out and my 8Mb 486 has been running 2.2.18pre
# with that fix and stably[1].

   Unfortunately, I don't think it is fixed. We maintain a heavy loaded
FTP/Samba server here (120+ active connections with very long data
transfers in rush hours) and it had the "VM: do_try_to_free_pages failed"
problem since 2.2.17 was first installed (there was FreeBSD before that).

   We aplied 2.2.18pre25 patch yesterday hoping it could solve it. The
only difference is that the server reached several hours uptime instead of
40 minutes (with pre24). After two hours of load between 6.00 and 15.00
the console was flooded with those unpopular messages ("VM: ..."). The
system was taken down by generation of these messages so quickly, that
even none of the messages appeared in syslog! No response to Ctrl-Alt-Del,
of course... :-( Just trashing...


On Fri, 8 Dec 2000, Andrea Arcangeli wrote:

# > Ok we believe the VM crash looping printing error messages is now fixed.
# Such bug can't generate crashes. Did you ever reproduced crashes on your 8Mb
# 486 with 2.2.18pre24?

   Our bug can generate them. :-( Maybe it's a different one? ;-)


   Is there any chance to get rid of these VMM failures?

   Sorry if I've missed something important recently mentioned here. I had
not enough time to follow the lk list carefully. Is there any reliable
solution?

   It seems we need to return back to 2.2.13 for some time. :-(
   Martin.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
