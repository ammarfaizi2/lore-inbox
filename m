Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133107AbQLJWEe>; Sun, 10 Dec 2000 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbQLJWEZ>; Sun, 10 Dec 2000 17:04:25 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:2831 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S133107AbQLJWEP>; Sun, 10 Dec 2000 17:04:15 -0500
Date: Sun, 10 Dec 2000 23:46:35 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.21.0012102105190.1601-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0012102346130.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Dec 2000, Tigran Aivazian wrote:

> If, however, you believe that the above _is_ the case but it should _not_
> happen then you are proposing a completely new policy of file structure
> allocation which you believe is superior. It is quite possible so let's
> all understand your new policy and let Linus decide whether it's better
> than the existing one. But if so, don't tell me you are fixing a bug
> because it is not a bug -- it's a redesign of file structure allocator.

If it's not a bug then

- this comment from include/linux/fs.h should be deleted
  #define NR_RESERVED_FILES 10 /* reserved for root */
- books should be updated
- people's mind also who believe kernel reserves fd's for superuser

Kernel from 2.1 plays lottery in this regards. And this would be
another sad fact that the kernel is exteremely poor *out of the box*
in regards security and relaibility ...

        Szaka


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
