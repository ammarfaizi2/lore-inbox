Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270057AbRHGD4V>; Mon, 6 Aug 2001 23:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270058AbRHGD4M>; Mon, 6 Aug 2001 23:56:12 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:56251
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S270057AbRHGD4E>; Mon, 6 Aug 2001 23:56:04 -0400
Date: Mon, 6 Aug 2001 20:56:15 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: David Spreen <david@spreen.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de>
Message-ID: <Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, David Spreen wrote:

> I was just searching for swap-encryption-solutions in the lkml-archive.
> Did I get the point saying ther's no way to do swap encryption
> in linux right now? (Well, a swapfile in an encrypted kerneli
> partition r something like that is not really what I want to
> do I think).

What's the benefit?  Sure, attackers have to know that encrypted swap is
in use, and have to be able to find the key in memory, but they already
can do both if they're root, and non-root can't [shouldn't be able to]
read swap devices on a properly secured machine.  Swap isn't meant for
storage across reboots/remounts, which is the only reason I can think of
for using encrypted loopback.  Once it's mounted, unless you have to enter
the password for every write, or unless it locks after some period of
inactivity (locking swap and requiring the password to unlock it sounds
like a fun proposition when the vm needs to swap), it's insecure until
it's locked/unmounted again.  Unmounting swap in a running system isn't
typical behavior.


justin

