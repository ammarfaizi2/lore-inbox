Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTK2Npz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 08:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbTK2Npz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 08:45:55 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14722 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263775AbTK2NpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 08:45:18 -0500
Date: Sat, 29 Nov 2003 13:50:00 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>, Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andrew Clausen <clausen@gnu.org>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
In-Reply-To: <20031129123451.GA5372@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands>
 <20031128142452.GA4737@win.tue.nl>
 <20031129022221.GA516@gnu.org>
 <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
 <20031129123451.GA5372@win.tue.nl>
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me continue to stress: geometry does not exist.
> Consequently, it cannot change.
> fdisk does not set any geometry, it writes a partition table.
> 
> Start and size of each partition are given twice: in absolute sector
> units (LBA) and in CHS units. The former uses 32 bits, and with 512-byte
> sectors this works up to 2TB. People are starting to hit that boundary now.
> The latter uses 24 bits, which works up to 8GB. Modern systems no longer
> use it (but the details are complicated).

Why don't we take the opporunity to make all CHS code configurable out
of the kernel, and define a new, more compact, partition table format
which used LBA exclusively, and allowed more than four partitions in
the main partition table?

I know it sounds pointless to define a new partitioning scheme when
there are so many already in existance, but for dedicated Linux
machines, only being able to define four partitions without resorting
to 'extended' partitions, which store there partitioning data in other
parts of the disk, is a needless limitation.  We could also ensure
that there is sufficient magic in the partition table to make
identifying it easy and reliable.

John.
