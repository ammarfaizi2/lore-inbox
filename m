Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTLJB2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 20:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTLJB2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 20:28:41 -0500
Received: from email-out2.iomega.com ([147.178.1.83]:60545 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263303AbTLJB2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 20:28:38 -0500
Subject: Re: partially encrypted filesystem
From: Pat LaVarre <p.lavarre@ieee.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Matthew Wilcox <willy@debian.org>, Erez Zadok <ezk@cs.sunysb.edu>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20031210000759.GA618@elf.ucw.cz>
References: <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk>
	 <200312051947.hB5Jlupp030878@agora.fsl.cs.sunysb.edu>
	 <20031205202838.GD29469@parcelfarce.linux.theplanet.co.uk>
	 <3FD127D4.9030007@lougher.demon.co.uk>
	 <1070883425.31993.80.camel@hades.cambridge.redhat.com>
	 <20031210000759.GA618@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1071019703.24032.26.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Dec 2003 18:28:23 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2003 01:28:37.0777 (UTC) FILETIME=[EF7FE010:01C3BEBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Even if you were going to admit to having a block size of 64KiB to the
> > layers above you, you just can't _do_ atomic replacement of blocks,
> > which is required for normal file systems to operate correctly.
> 
> Are those assumptions needed for something else than [1] recovery after
> crash/powerdown? [i.e., afaics 64K ext2 should work on flash, but fsck
> might have some troubles...]

2) Space occupied divided by space usable.  Rounding up file sizes to 64
KiB can waste much space.

3) Thruput.  Read 64 KiB to overlay one byte to write back as 64 KiB can
be slow, especially in devices that spin slowly (e.g. 10,000rpm) to
reach the 64 KiB block again.

4) ... anyone know?

Pat LaVarre


