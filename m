Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVCAXiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVCAXiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVCAXiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:38:16 -0500
Received: from smtp06.auna.com ([62.81.186.16]:42644 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262130AbVCAXhq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:37:46 -0500
Date: Tue, 01 Mar 2005 23:37:27 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.11-rc5: Promise SATA150 TX4 failure
To: Joerg Sommrey <jo@sommrey.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050301014514.GA10653@sommrey.de>
X-Mailer: Balsa 2.3.0
Message-Id: <1109720247l.10975l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.01, Joerg Sommrey wrote:
> Hi all,
> 
> a problem that was introduced between 2.6.10-ac9 and 2.6.10-ac11 made
> it's way into 2.6.11-rc5.  While taking a backup onto a SCSI-streamer one
> of my RAID1-arrays gets corrupted.  Afterwards the system hangs and
> isn't even bootable.  Need to raidhotadd the failed partition in single
> user mode to get the box working again. Error messages:
> 

Me too :(. Just a slightly different case.
I have a server with 6x250Gb SATA drives, hanged on a pair of Promise
PDC20319 (FastTrak S150 TX4) (rev 02) controlers (each has 4 ports).
Main use for the box is as a smb/atalk/nfs server.

With 2.6.20-rc3-mm2+libata-dev2, the box is stable, we can drop
gigs of files throug samba amd it works. 
Anything newer that that makes the box hang siliently, no messages,
no oops. It also happened to me with just a local wget of a big
file (oofice-2.0-beta), after download the box locked hard.

I tried to apply libata-dev1 on top of newer kernels, but part of it
is already there, and the rest drops too many rejects/offsets for
me.

I also have one other problem with flock, but thats subject for another
post...

Any ideas about what changed wrt sata ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam12 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1










