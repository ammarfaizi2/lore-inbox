Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136482AbRD3IrN>; Mon, 30 Apr 2001 04:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136483AbRD3IrD>; Mon, 30 Apr 2001 04:47:03 -0400
Received: from [194.128.63.73] ([194.128.63.73]:50571 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S136482AbRD3Iqs>; Mon, 30 Apr 2001 04:46:48 -0400
Message-ID: <3AED26B0.8598C241@ukaea.org.uk>
Date: Mon, 30 Apr 2001 09:47:44 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
Organization: UKAEA Fusion
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.21.0104270953280.2067-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya.

Linus Torvalds wrote:
> So anybody who depends on "dump" getting backups right is already playing
> russian rulette with their backups.  It's not at all guaranteed to get the
> right results - you may end up having stale data in the buffer cache that
> ends up being "backed up".
> 
> Dump was a stupid program in the first place. Leave it behind.

Ouch.  I just re-read the man page and it doesn't caution (*) against
using it on mounted filesystems.  That probably means that there are
thousands of other losers like me using it on production machines. 
Volunteers to (a) change the man page, (b) talk to the distros about
dumping "dump"?

> However, it may be that in the long run it would be advantageous to have a
> "filesystem maintenance interface" for doing things like backups and
> defragmentation..

Yup, sounds good.

Neil

(*) The KNOWNBUGS file mentions "possible" problems while dumping active
mounted filesystems, but I've (elsewhere) seen these characterised as no
real problem; also, this falls a long way short of discouraging use in
this fashion.
