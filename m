Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUCJWIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUCJWIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:08:21 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:229 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262854AbUCJWIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:08:18 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thomas Horsten <thomas@horsten.com>
Subject: Re: [PATCH] 2.4.x Linux Medley RAID Version 7
Date: Wed, 10 Mar 2004 23:14:18 +0100
User-Agent: KMail/1.5.3
Cc: Christoph Hellwig <hch@infradead.org>, <andre@linux-ide.org>,
       <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.40.0403101917170.2582-100000@jehova.dsm.dk>
In-Reply-To: <Pine.LNX.4.40.0403101917170.2582-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403102314.18449.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 of March 2004 21:11, Thomas Horsten wrote:
> On Wed, 10 Mar 2004, Bartlomiej Zolnierkiewicz wrote:
> > Patch for inclusion should have this cleaned up.
>
> I have cleaned up the code according to your and Christoph's comments +
> CodingStyle (and some other cleanups now I was at it).

Ok, thanks.

> > The similar thing here - ie. I would like to replug drives to on-board
> > Intel. When Linux is driving RAID purely in software it shouldn't matter
> > what controller we are using.
>
> I have not changed this. There is simply no reliable way to detect the
> Medley superblock without comparing these magic words with the PCI values.

There is still a checksum.

> My Medley solution for 2.6 will be completely userspace (using dm), and
> there it will be possible to "force detect" an array with non-matching PCI
> ID by passing the devices as command line arguments, unfortunately it's
> not that easy in 2.4 (the whole ataraid is a hack anyway, but a useful one
> until something better is in place).

Yep, device-mapper is the way to go.

> Patch below.

I will submit it to Marcelo soon...

Regards,
Bartlomiej

