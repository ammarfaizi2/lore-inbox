Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbRBKSjR>; Sun, 11 Feb 2001 13:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129384AbRBKSjI>; Sun, 11 Feb 2001 13:39:08 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:59144 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129300AbRBKSi6>; Sun, 11 Feb 2001 13:38:58 -0500
Date: Sun, 11 Feb 2001 18:38:56 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <linux-kernel@vger.kernel.org>
cc: <davem@redhat.com>
Subject: BUG: SO_LINGER + shutdown() does not block?
Message-ID: <Pine.LNX.4.30.0102111835060.10619-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>From socket(7):

       SO_LINGER
...
              When  enabled,  a  close(2) or shutdown(2) will not
              return until all queued  messages  for  the  socket
              have  been  successfully sent or the linger timeout
              has been reached.

I'm not seeing shutdown(2) block on a TCP socket. This is Linux kernel
2.2.16 (RH7.0). Is this a kernel bug, a documentation bug, or does it all
work fine and it's a Chris bug?

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
