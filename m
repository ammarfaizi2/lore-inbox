Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLPXk4>; Sat, 16 Dec 2000 18:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbQLPXkp>; Sat, 16 Dec 2000 18:40:45 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:12302 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129450AbQLPXk3>; Sat, 16 Dec 2000 18:40:29 -0500
Date: Sat, 16 Dec 2000 17:10:00 -0600
To: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
Message-ID: <20001216171000.L3199@cadcamlab.org>
In-Reply-To: <20001215152137.K599@almesberger.net> <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com> <91e0so$9bn$1@enterprise.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <91e0so$9bn$1@enterprise.cistron.net>; from miquels@traveler.cistron-office.nl on Fri, Dec 15, 2000 at 09:02:16PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Miquel van Smoorenburg]
> In fact, the 2.2.18 kernel already puts a 'build' symlink in
> /lib/modules/`uname -r` that points to the kernel source,
> which should be sufficient to solve this problem.. almost.
> 
> It doesn't tell you the specific flags used to compile the kernel,
> such as -m486 -DCPU=686

Sure it does.

  make -C /lib/modules/`uname -r`/build modules SUBDIRS=$(pwd)

or, if you like clumsy and slow:

  SRCDIR := /lib/modules/`uname -r`/build
  CFLAGS := $(shell $(MAKE) -s -C $(SRCDIR) script SCRIPT='echo $$$$CFLAGS')

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
