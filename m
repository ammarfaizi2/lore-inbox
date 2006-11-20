Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966236AbWKTRWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966236AbWKTRWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966238AbWKTRWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:22:46 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64213 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S966236AbWKTRWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:22:45 -0500
Date: Mon, 20 Nov 2006 17:28:12 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: avl@logic.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061120172812.64837a0a@localhost.localdomain>
In-Reply-To: <20061120165601.GS6851@gamma.logic.tuwien.ac.at>
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at>
	<20061120152505.5d0ba6c5@localhost.localdomain>
	<20061120165601.GS6851@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While I used Knoppix to determine the age of the bug, it does also
> appear with a plain vanilla 2.6.18.2 kernel from www.kernel.org.
> The ChangeLog for 2.6.18.3 also doesn't mention ide-disk.

The old IDE layer does not currently have a maintainer.
 
> I must admit, I don't know about GPT.  My system's bios
> is old enough to not know about EFI, and the partition-scheme
> on that harddisk dates back quite a few years, so it's unlikely
> to be anything than the good ol' MBR.

The reason I ask is that they put the partition in the last sector which
means a block read of the last sector goes off the end of the disk and
certainly used to be mishandled by the IDE code.

> Alternatively, a kernel-option to manually disable hpa-checking
> would be a good step to solve the problem even for drives like mine.

It's a compile time option. If you don't have GPT partitioning support
then the system ought to behave correctly.

Alan
