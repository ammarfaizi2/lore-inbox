Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQKQHAV>; Fri, 17 Nov 2000 02:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbQKQHAM>; Fri, 17 Nov 2000 02:00:12 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:26628 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129314AbQKQHAF>; Fri, 17 Nov 2000 02:00:05 -0500
Date: Fri, 17 Nov 2000 00:30:00 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001117003000.B2918@wire.cadcamlab.org>
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116150704.A883@emma1.emma.line.org> <20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001116115249.A8115@wirex.com>; from jesse@wirex.com on Thu, Nov 16, 2000 at 11:52:49AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[jesse]
> 1.  Your server closes all open directory file descriptors and chroots.
> 2.  Someone manages to run some exploit code in your process space which--

  mkdir("foo")
  chroot("foo")
  chdir("../../../../../../../../../..")
  chroot(".")

  mkdir proc
  mount -t proc none proc
  cd proc/1/cwd

Two easy "get out of jail free" cards.  There are other, more complex
exploits.  You have added one more.  They all require root privileges.

Bottom line: once you are in the chroot jail, you must drop root
privileges, or you defeat the purpose.  Security-conscious coders know
this; it's not Linux-specific behavior or anything.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
