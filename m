Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbRDBMWK>; Mon, 2 Apr 2001 08:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131657AbRDBMWA>; Mon, 2 Apr 2001 08:22:00 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:14352 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131625AbRDBMVq>;
	Mon, 2 Apr 2001 08:21:46 -0400
Date: Mon, 2 Apr 2001 14:19:18 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk
Subject: ARM port missing pivot_root syscall
Message-ID: <20010402141918.A17334@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few months ago a colleague was frustrated to find pivot_root missing
from the ARM port.  Semi-standard C programs that use this call would
not compile for the ARM.  Perhaps you ARM folks would like to add it?

It's probably an oversight.  Perhaps the person who added
__NR_pivot_root to the other architectures and updated the syscall table
did so before the ARM port was integrated, or perhaps the change was
lost or something like that.

On this general theme, there are other constants, whose names are not
arch-specific but whose _values_ are arch-specific.  E.g. look in
<asm/fcntl.h>.  In most cases, some of the values are required for
historical compatibility, sometimes with other operating systems.

I wonder if there are other constants missing from some ports in the
same way that __NR_pivot_root was left out of the ARM point.

Just something to think about.  Perhaps someone enthusiastic would like
to audit.

have a nice day,
-- Jamie
