Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265208AbRF0CME>; Tue, 26 Jun 2001 22:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265212AbRF0CLy>; Tue, 26 Jun 2001 22:11:54 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:12306 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S265208AbRF0CLh>; Tue, 26 Jun 2001 22:11:37 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot 
cc: pmenage@ensim.com
In-Reply-To: Your message of "Tue, 26 Jun 2001 21:40:36 EDT."
             <Pine.GSO.4.21.0106262138370.18037-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 19:17:57 -0700
Message-Id: <E15F4tx-0003sA-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>You need to be root to do mknod. You need to do mknod to create /dev/zero.
>You need /dev/zero to get anywhere near the normal behaviour of the system.
>

Sure, but we're not necessarily looking for a system that behaves
normally in all aspects. The example given was that of a paranoid
network server that does all its initialisation in a normal environment,
and then does a chroot to its data directory. Or alternatively, forks
after accepting a connection, and the child does a chroot. No need to be
able to exec other programs, etc. Such a daemon is certainly possible,
as I've written one myself. But it had to be started by root, rather
than by a normal user.

I'm not claiming that the user chroot patch is necessarily useful enough
to be included in the standard kernel - merely that it does have some
real-world uses.

Paul


