Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271259AbTGPXRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271255AbTGPXQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:16:23 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21930 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271221AbTGPXPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:15:40 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 17 Jul 2003 01:30:32 +0200 (MEST)
Message-Id: <UTC200307162330.h6GNUWj01518.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, Valdis.Kletnieks@vt.edu
Subject: Re: what is needed to test the in-kernel crypto loop?
Cc: ahu@ds9a.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From Valdis.Kletnieks@vt.edu  Tue Jul 15 20:29:45 2003

    On Fri, 11 Jul 2003 15:46:55 +0200, Andries.Brouwer@cwi.nl said:

    > Try util-linux 2.12, available in 60 hours.

    (using this version from ftp.kernel.org/pub/linux/utils/util-linux:
    -rw-r--r--   1 korg     korg      1285674   Jul 13 22:09   util-linux-2.12pre.tar.bz2

    Umm.. OK... I'll bite.  How do I get 2.12pre to actually use cryptoloop?

Ah, 2.12pre is not 2.12.

(2.12pre is a solid version, I hope, nothing wrong with it,
but no new loop stuff; someone was willing to test it and
did not come back with complaints, so maybe it isnt too bad.)

(On the other hand, concerning 2.12 I hesitated for a long time.
Jari came with code that works perfectly, but is such a lot of
cruft. Did I really want to maintain that? Lots of cryptoalgorithms
built into mount? On ftp.cwi.nl under /pub/aeb/util-linux there
was a util-linux-2.12-wip.tar.gz for a month or so, but I removed it
and replaced it by util-linux-2.12.tar.gz.
This new losetup/mount is minimal instead of maximal, smaller than
the older versions. Good for playing, but people who really have
their filesystems on loop-aes or cryptoloop had better wait before
rushing and installing this.)

A main reason for discrepancy is that no knowledge about cryptoalgorithms
is built into mount/losetup. With a -p option these programs are willing
to read a possibly encrypted passphrase from a given file descriptor.
All passphrase handling can now be external to mount, I hope.
No doubt more polishing is needed.

Nothing has been tested. (But it compiles here.)

Please test and report.

Andries
