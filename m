Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268599AbRG3WUr>; Mon, 30 Jul 2001 18:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268657AbRG3WUi>; Mon, 30 Jul 2001 18:20:38 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:24753 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268599AbRG3WUT>; Mon, 30 Jul 2001 18:20:19 -0400
To: Mike Touloumtzis <miket@bluemug.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
In-Reply-To: <Pine.GSO.4.21.0107301646050.19391-100000@weyl.math.psu.edu> <20010730141427.E20284@bluemug.com>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 30 Jul 2001 18:16:40 -0400
In-Reply-To: Mike Touloumtzis's message of "Mon, 30 Jul 2001 14:14:27 -0700"
Message-ID: <m2ofq26p13.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>>>>> "Mike" == Mike Touloumtzis <miket@bluemug.com> writes:
[snip]
 Mike> Hmmm, maybe we need ramfs-backed-by-romfs :-).  But a lot of
 Mike> people in the embedded/consumer electronics space could get by
 Mike> just fine with a read-only / and a ramfs or ramdisk on /tmp.

I am not so sure about this.  Typical flash access times are rather
long compared to SDRAM.  StrataFlash and other bursting flash are
rather new and require specific CPUs or custom logic to access the
flash in a sequential mode.

In my personal experience, code is usually compressed in flash (or
ROM) and expanded into SDRAM.  You can always use an MMU to achieve
the RO effects of flash/ROM.  The big win for flash execution is that
the power numbers are typically lower... but since it takes longer to
execute, it washes out to the same.  But some paranoid hardware people
don't like `peak drains' on a battery so they might prefer Flash
execution.  The flexibility is nice whatever the case; it might become
more of an issue if bursting/sequential flash devices become more
common.  I don't know if there is a big push for this though.  The cost
of burst flash is still greater than SDRAM afiak.

fwiw,
Bill Pringlemeir.



