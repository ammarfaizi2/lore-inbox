Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281192AbRLDSCC>; Tue, 4 Dec 2001 13:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRLDSAm>; Tue, 4 Dec 2001 13:00:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24581 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281201AbRLDR4B>; Tue, 4 Dec 2001 12:56:01 -0500
Subject: Re: Linux/Pro  -- clusters
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Tue, 4 Dec 2001 18:04:12 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), becker@scyld.com (Donald Becker),
        davidel@xmailserver.org (Davide Libenzi),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <E16BJBR-0000RM-00@starship.berlin> from "Daniel Phillips" at Dec 04, 2001 06:16:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BJvR-0002uc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Single additional alloc -> twice as many allocs, two slabs, more cachelines
> dirty.  This was hashed out on fsdevel, though apparently not to everyone's
> satisfaction.

Al Viro's NFS in generic_ip saved me something like 130K of memory.

> > Using generic_ip in its current form has the advantage of being able to
> > create a nicely-aligned kmem cache for your private inode data.
> 
> I don't see why that's hard with the combined struct.

Providing you end up with fs->alloc_inode() and the fs allocates a suitable
sized inode + private I see no problem.
