Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRBNFsO>; Wed, 14 Feb 2001 00:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129681AbRBNFsE>; Wed, 14 Feb 2001 00:48:04 -0500
Received: from smtp8.us.dell.com ([143.166.224.234]:16399 "EHLO
	smtp8.us.dell.com") by vger.kernel.org with ESMTP
	id <S129136AbRBNFry>; Wed, 14 Feb 2001 00:47:54 -0500
Date: Tue, 13 Feb 2001 23:47:50 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Michael E Brown <michael_e_brown@exchange.dell.com>,
        <Andries.Brouwer@cwi.nl>, <Matt_Domsch@exchange.dell.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <3A89CF93.A934C473@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0102132343250.1882-100000@carthage.michaels-house.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Manfred Spraul wrote:

> I have one additional user space only idea:
> have you tried raw-io? bind a raw device to the partition, IIRC raw-io
> is always in 512 byte units.

That has been tried. No, it does not work. :-)  Using Scsi-Generic is the
only way so far found, but of course, it only works on SCSI drives.

>
> Probably an ioctl is the better idea, but I'd use absolute sector
> numbers (not relative to the end), and obviously 64-bit sector numbers -
> 2 TB isn't that far away.
>

I was deliberately trying to limit the scope to avoid misuse. This is to
work around a flaw in the current API, not to create a new API. Limiting
access to only those blocks that would normally be inaccessible through
the normal API seemed like the best bet to me.

--
Michael Brown

