Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbRDXQvt>; Tue, 24 Apr 2001 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132808AbRDXQvk>; Tue, 24 Apr 2001 12:51:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19329 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132862AbRDXQv2>; Tue, 24 Apr 2001 12:51:28 -0400
Date: Tue, 24 Apr 2001 12:51:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Masaki Tsuji <jammasa@ma.nma.ne.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: Can't read SCSI TAPE
In-Reply-To: <3AE5A483.FCF3F99@ma.nma.ne.jp>
Message-ID: <Pine.LNX.3.95.1010424123227.15270A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Masaki Tsuji wrote:

> Dear sirs,

Hmmm...

Masaki Tsuji <jammasa@ma.nma.ne.jp>
                      ^^^^^^^^^^^^ ____ This address

... was the address that did the CA-2000-17 attack on one of
our machines a few weeks ago.

This is not an accusation, only an observation. You might
want to tell your network administrator. Sombody at your
site may be hacking systems.

SCSI tape problems or your kind are usually caused by a different
tape compression being used during record and playback. You should
try to use `mt` to set the compression to something you like
before you record, and the same compression when you play back
the tape.

You can use `cat` and `od` to read/write from a tape before you
waste a lot file time with `tar`. You can even do:

		ls >/dev/tape
                 .... takes a lot of time..

		cat /dev/tape  # Read back.

Blocking/deblocking is done in the driver so you can treat it as
a "slow-to-start" FIFO.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


