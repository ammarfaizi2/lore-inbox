Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132205AbRAZP1J>; Fri, 26 Jan 2001 10:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132293AbRAZP07>; Fri, 26 Jan 2001 10:26:59 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:13852 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S132205AbRAZP0z>; Fri, 26 Jan 2001 10:26:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.38717.250220.501376@somanetworks.com>
Date: Fri, 26 Jan 2001 10:26:53 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: "Michael B. Trausch" <fd0man@crosswinds.net>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
        Zack Brown <zab@redhat.com>
Subject: Re: Possible Bug:  drivers/sound/maestro.c
In-Reply-To: <Pine.LNX.4.21.0101260220430.11818-100000@fd0man.accesstoledo.com>
In-Reply-To: <Pine.LNX.4.21.0101260220430.11818-100000@fd0man.accesstoledo.com>
X-Mailer: VM 6.75 under 21.2  (beta40) "Persephone" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MBT" == Michael B Trausch <fd0man@crosswinds.net> writes:

 MBT> I've been using this driver and this hardware since I started
 MBT> running Kernel 2.2.16.  It _works_, however, whenever I have a
 MBT> program that I compile that's especially large (the kernel,
 MBT> glibc, etc.), or copy/move lots of files around, the driver
 MBT> starts to fuzz lots of the sound going to the card - even after
 MBT> the activity causing the load has stopped.  It happens in both
 MBT> the left and the right channel, and the only way to resolve it
 MBT> is to kill the process with /dev/dsp open (typically mpg123),
 MBT> and then start it again.

FWIW, I too was having this kind of problem.  When I starting living
on 2.4.x kernels the problem went away.  Also gone were sound dropping
out when I busied my machine with compiles things.

Of course, I'm omitting the irrelevant detail of the absence of the
pci_enable_dev() call 2.4.0-testX where X<12 which caused the driver
to not work at all.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
