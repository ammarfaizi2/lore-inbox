Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTLEP0W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 10:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbTLEP0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 10:26:22 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:4054 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S264163AbTLEP0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 10:26:20 -0500
Date: Fri, 5 Dec 2003 16:26:18 +0100
From: Eduard Bloch <edi@gmx.de>
To: Torsten Scheck <torsten.scheck@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-FAT32-Filesystem Bug
Message-ID: <20031205152618.GA10802@zombie.inka.de>
References: <3FD0555F.5060608@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD0555F.5060608@gmx.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin Torsten!
Torsten Scheck schrieb am Friday, den 05. December 2003:

> I found a critical FAT32 bug when I tried to store data onto an
> internal IDE 160 GB and onto an external USB2/FW-250 GB hard
> disk.
> 
> From a certain fill level on, the data clusters of a newly added
> file entry get lost after a remount of the filesystem: the
> directory entry of the file has the size 0, the data is lost, and
> a fsck.vfat -r is needed to remove the unused clusters.

Funny (not), I noticed almost the same problem with a Firewire 250GB HD
(Maxtor). The data has been written to it (FAT32, 200gb-Partition), but
large files (IMO >= 1GB) got zero size and the data disappeared.
Scandisk from Windows could not find any errors, however the displayed
free space on this FAT filesystem has been lowered by the ammount of the
data written too it :(

I will try fsck.vfat later.

MfG,
Eduard.
