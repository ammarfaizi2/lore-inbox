Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNTzi>; Thu, 14 Dec 2000 14:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLNTzS>; Thu, 14 Dec 2000 14:55:18 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:62215 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129260AbQLNTzK>;
	Thu, 14 Dec 2000 14:55:10 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012141924.WAA02993@ms2.inr.ac.ru>
Subject: Re: linux ipv6 questions.  bugs?
To: mgm@paktronix.com (Matthew G. Marsh)
Date: Thu, 14 Dec 2000 22:24:18 +0300 (MSK)
Cc: pete@research.netsol.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012141304150.16343-100000@netmonster.pakint.net> from "Matthew G. Marsh" at Dec 14, 0 01:11:06 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I have several different boxen (test11, test12) that do something very
> similar. They cannot ping6 the link-local addresses at all. As in:
> 
> [root@paksecuredX tech]# ping6 ::1
> PING ::1(::1) from ::1 : 56 data bytes
> 64 bytes from ::1: icmp_seq=0 hops=64 time=351 usec
> 64 bytes from ::1: icmp_seq=1 hops=64 time=200 usec

This does not look similar. I daresay it rather looks working well. 8)8)


> [root@paksecuredX tech]# ping6 fe80::210:5aff:fe05:e828
> connect: Invalid argument

Right, you forgot to tell what interface you expect.
Address is link local yet, it is invalid without interface.

ping6 -I eth0 fe80::210:5aff:fe05:e828


> Now from my local box which is running 2.2.12 I can ping the link-local of
> those boxes. IE:

It was bug, it is fixed.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
