Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286966AbSABMET>; Wed, 2 Jan 2002 07:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286978AbSABMEI>; Wed, 2 Jan 2002 07:04:08 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:39318 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S286968AbSABMD5>; Wed, 2 Jan 2002 07:03:57 -0500
Date: Wed, 2 Jan 2002 12:03:26 +0000 (GMT)
From: Jon Masters <jonathan@jonmasters.org>
To: linux-kernel@vger.kernel.org
cc: admin@intelligentspace.com
Subject: Panics, kernel 2.4
Message-ID: <Pine.LNX.4.10.10201021136110.14437-100000@router>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of the fileservers at work is running 2.4.14. It is a 900MHz Duron
with 1.5GB physical RAM, 3c905, etc. and it handles three software RAID
arrays based on ATA100 PCI IDE, which contain reiserfs filesystems. It can
get quite loaded at times and we use most of the available memory for
about 300 processes or so on average.

A few months ago, we started to notice problems under certain load
conditions - particularly when running a distributed Java processing
application we have in house which tries to allocate several GB of memory
for handling matrix calculations. I ran many burnk7 processes,
distributed.net, john, etc. etc. and got the load average beyond 300
without trouble for several hours. I've run a full memtest86 on it and
also written a couple of small programs to malloc very large chunks of
memory and perform some simple manipulations with them, that works fine
too. The environmental conditions are reasonable and the cooling is
functioning normally (I've even installed additional fans to be sure).

Still, these problems persisted until we decided to no longer use
overnight idle processing power on that machine and moved the java server
to another box. I put it down to having perhaps found a new vm bug in 2.4
or something (or somehow having very very strange hardware issues).

Today the problem is back, symptoms they have reported to me (I work part
so it's quite difficult to deal with these types of problem sometimes) are
that their samba shares dissappeared and there "might be a network problem
of some kind". I attempted to login immediately and the machine was still
semi up since I was able to get part way through an ssh authentication
before the box went dead (it probably started killing stuff or something).

I think it's paniced again however the serial console is
unavailable (will install one today) and as they need that box I have
asked them to power cycle it (as I write this it's been 30 minutes and
it's just started to respond). This clearly is not ideal and I would like
some recommendations for debugging this problem without hurting the fact
that it's a production server that should continue running. The logs never
show anything useful obviously but I will install a serial console to
watch it today and report logs from future kernel panics. I have observed
a panic myself recently however do not have the output to report here.

Tonight I shall be upgrading to 2.4.17 and will run a bunch more tests
(additional suggestions for tests welcome).

I apologise for not having a full bug report, this is kinda weird. I
would just appreciate any advice or suggestions really.

Happy new year to all,

--jcm

