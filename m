Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154180-13684>; Thu, 7 Jan 1999 08:07:19 -0500
Received: by vger.rutgers.edu id <155196-13684>; Wed, 6 Jan 1999 22:33:50 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:3342 "HELO ms2.inr.ac.ru" ident: "IDENT-NONSENSE") by vger.rutgers.edu with SMTP id <154198-13684>; Wed, 6 Jan 1999 10:59:10 -0500
Date: Wed, 6 Jan 1999 21:19:14 +0300
From: kuznet@ms2.inr.ac.ru
Message-Id: <199901061819.VAA08689@ms2.inr.ac.ru>
To: vlad@elis.tusur.RU, linux-kernel@vger.rutgers.edu
Subject: Re: [PATCH] Fixes in ipv4 networking code
Newsgroups: inr.linux.kernel
Organization: Institute for Nuclear Research, Moscow, Russia
X-Newsreader: TIN [version 1.2 PL2]
Sender: owner-linux-kernel@vger.rutgers.edu

In article <199901050932.QAA06101@elis.tusur.ru> you wrote:
: 1. "ip route get <SOMETHING>" never returns flowid. Fixed.
: 2.  Flowid setting in rules doesn't work. Fixed.

These two fixes have been queued. I apologize, they are not very urgent
and, in any case, anyone using these features needs to patch kernel
with ftp://ftp.inr.ac.ru/ip-routing/kernel-ss*.dif.gz.

: 3.  Routes with THROW flag doesn't work. Fixed.

Oops... Yes. Only the fix is wrong... Checking for 1 will terminate search,
when prespecified device is requested, which is certainly wrong.
Khm... The bug is very unpleasant... I'll think. Can you invent something
better than returning 2 instead of 1 in the case when fib_semantic_match
failure not because of throw?

: 4.  Sometimes "ip route get <SOMETHING>" returns an unknown error code,
: looks like a very big number. Fixed.

Thank you!

Alexey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
