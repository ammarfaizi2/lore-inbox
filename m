Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbTIZNz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 09:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbTIZNz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 09:55:29 -0400
Received: from [170.180.5.203] ([170.180.5.203]:63757 "EHLO
	e151000n0.edmonson.k12.ky.us") by vger.kernel.org with ESMTP
	id S262208AbTIZNz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 09:55:28 -0400
Message-ID: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA884@E151000N0>
From: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
To: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "'Lou Langholtz'" <ldl@aros.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Date: Fri, 26 Sep 2003 08:51:45 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.0-test4 should be okay, unless you have Promise PDC20265,
> then you should use 2.6.0-test5 (allows LBA48 DMA on PDC20265).

Well I do have a PDC20265, so I installed the 2.6.0test5 rpm from

http://people.redhat.com/arjanv/2.5/RPMS.kernel/

That allowed me to get access to the whole drive.  I made an ext3 filesystem
on it and everything mounted real nice.  Unfortunately, now after about a
minute of hard copying the IDE channels timeout and reset.  I get the
timeout on hdg (which is the 250G drive), but the filesystem on hdf (which
is a 120G drive that I am copying from) get corrupted.  I didn't have this
problem with any of the other kernels, so I think it might have something to
do with what went in for test5.  I am still looking at that though.  I am
also going to try moving the drive that is currently hdf onto the standard
motherboard channels so that it isn't on that controller.  I hope to get the
source rpm for 2.6.0test5 and the .config for it tonight and try recompiling
with some different options.  Does any one have any suggestions on what I
should look for?

Thanks for all you help you guys have been really great.

Brent 
