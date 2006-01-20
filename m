Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWATP2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWATP2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 10:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWATP2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 10:28:45 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:31964 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1750795AbWATP2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 10:28:44 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH 000 of 5] md: Introduction
Date: Fri, 20 Jan 2006 16:48:36 GMT
Message-ID: <0610HD112@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
>
> These can be mixed together quite effectively:
> You can have dm/lvm over md/raid1 over dm/multipath
> with no problems.
>
> If there is functionality missing from any of these recommended
> components, then make a noise about it, preferably but not necessarily
> with code, and it will quite possibly be fixed.

Chiepest high capacity is now provided through USB connected external disks.
Of course, it's for very low load.

So, what would be helpfull is let's say have 7 usefull disks, plus 1 for parity
(just like RAID4), but with not a result of one large partition, but with
the result of seven partitions, one on each disk.

So, in case of one disk failure, you loose no data,
in case of two disks failure, you loose 1/7 partition,
in case of three disks failure, you loose 2/7 partitions,
etc, because if the RAID4 is unusable, you can still read each partition
as a non raid partition.

Somebody suggested that it could be done through LVM, but I failed to find
the way to configure LVM on top of RAID4 or RAID5 to grant that each
partition sectors are consecutive all on a single physical disk.

