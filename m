Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbRGRPnc>; Wed, 18 Jul 2001 11:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267886AbRGRPnW>; Wed, 18 Jul 2001 11:43:22 -0400
Received: from mail11.bigmailbox.com ([209.132.220.42]:46094 "EHLO
	mail11.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S267493AbRGRPnT>; Wed, 18 Jul 2001 11:43:19 -0400
Date: Wed, 18 Jul 2001 08:43:17 -0700
Message-Id: <200107181543.IAA09976@mail11.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [198.253.22.197]
From: "Jonathan Day" <jd9812@my-deja.com>
To: linux-kernel@vger.kernel.org
Subject: Paging problem, own fault, need help digging out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I've reached a sticking problem with the FOLK project. The 2.x series of patches include a variety of additional gunk. Somewhere in there, it's messing up the memory manager. Using everything from SGI's KDB to a large sledgehammer, I've managed to identify that the problem occurs in the kernel's init process.

   What's happening seems straight-forward enough. It runs through the initialization OK, then tries to execve the init process. The init process hits a page fault, and the kernel promptly explodes.

   If people on this list had the spare time to clean up after every kernel I'd exploded, Linux would be on version 5, would run on a 7 teraflop processor, and form the backbone of the 4 terabit cable network that was a standard fitting to every house on the planet.

   On the other hand, I'm hoping that someone might have some ideas on what sorts of things I could check, which files might be worth adding debug statements to, etc. I really want to actually do the debugging myself, but I'm not too proud to say that I'm befuddled and need some help on getting started with this one.

   Thanks in advance for -any- help anyone can give.

Jonathan Day




------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/
