Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277860AbRJIRZs>; Tue, 9 Oct 2001 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277856AbRJIRZf>; Tue, 9 Oct 2001 13:25:35 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19602 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277177AbRJIRZ0>; Tue, 9 Oct 2001 13:25:26 -0400
Date: Tue, 9 Oct 2001 11:25:35 -0600
Message-Id: <200110091725.f99HPZ530405@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Matt Domsch <mdomsch@Dell.com>
Cc: <torvalds@transmeta.com>, <alan@redhat.com>,
        "'Martin.Wilck@Fujitsu-Siemens.com'" 
	<Martin.Wilck@Fujitsu-Siemens.com>,
        "'viro@math.psu.edu'" <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EFI GUID Partition Tables
In-Reply-To: <Pine.LNX.4.33.0110091210080.6027-100000@tux.us.dell.com>
In-Reply-To: <Pine.LNX.4.33.0110091210080.6027-100000@tux.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch writes:
> Prompted by Al Viro's work to move the partition table handling code
> from using block device access to using the page cache, I've pulled
> the EFI GUID Partition Table (GPT) code from the IA-64 port patch
> and updated it.  I would like to see it included in the Linus and
> -ac trees, as it barely needs the IA-64 tree, and even then, only
> asm-ia64/efi.h which is already merged.  David Mosberger is happy to
> have it dropped from the IA-64 port.  This code has been in use on
> IA-64 for quite a while now, so I feel confident that it works.
> I've also used it quite a bit on x86.  The devfs GUID support is by
> Martin Wilck.

You've put the devfs_unregister_slave() inside an #ifdef. Yuk! It
shouldn't be conditional. And I'm not really sure that I like this
function in the first place, but that's not something I want to get
into right now.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
