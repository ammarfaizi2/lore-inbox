Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUIEAQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUIEAQk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 20:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUIEAQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 20:16:40 -0400
Received: from smtpout3.compass.net.nz ([203.97.97.135]:22745 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S264795AbUIEAQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 20:16:37 -0400
Date: Sun, 5 Sep 2004 12:17:07 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@linuxcd
Reply-To: haiquy@yahoo.com
To: pavel@atrey.karlin.mff.cuni.cz
cc: linux-kernel@vger.kernel.org
Subject: nbd questions and problems
Message-ID: <Pine.LNX.4.53.0409051154170.21075@linuxcd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have just tested nbd and got touble with it.

Kernel 2.6.8.1 (from kernel.org)

nbd server and client version

When I download the latest version there are many patches under the directory
nbd but when run configure it seems not to apply any patch. No README file
to instruct anything.
So I just ./configure then make. produce nbd-client and nbd-server
The nbd kernel module is the original one from 2.6.8.1

dd if=/dev/zero of=swap bs=1M count=64
nbd-server 1024 swap

The client is a diskless ; get its root via NFS . In client I run

nbd-client 10.0.0.2 1024 /dev/nbd/0

mkswap /dev/nbd/0

swapon /dev/nbd/0

It seems fine, but when the system touch swap there are error in the kernel log

nbd0 Receive control failed result -104

and the server exited .

If I run
nbd-client 10.0.0.2 1024 /dev/nbd/0 -swap

it ask me to apply some patches to work but there is no documentation I found on net
or in the nbd tar ball tell me which patch t apply

And now if I dont use swap, I did exactly like the above and then run
mke2fs /dev/nbd/0

It immiedately gave errors like
---
nbd0: Receive control failed (result -104)
nbd0: shutting down socket
-- many other error which is because of the above one

Is there anyway to fix these? please help.

Steve Kieu
