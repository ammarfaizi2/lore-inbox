Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131930AbRASPpl>; Fri, 19 Jan 2001 10:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131961AbRASPpb>; Fri, 19 Jan 2001 10:45:31 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:516 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S131930AbRASPpL>;
	Fri, 19 Jan 2001 10:45:11 -0500
Message-ID: <3A6860F9.EC882411@holly-springs.nc.us>
Date: Fri, 19 Jan 2001 10:44:57 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mo McKinlay <mmckinlay@gnu.org>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <Pine.LNX.4.30.0101191516360.2331-100000@nvws005.nv.london>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mo McKinlay wrote:

> (Take symbolic linking, for example - if you ln -s on VFAT, you get
> 'operation not permitted' - named stream/EA operations on a filesystem
> that doesn't support them should return the same, IMHO).

And they would, if the chosen namespace was not supported.

> Also, I don't like the idea of bypassing POSIX in this manner (using ':'
> as a delimeter), even if the underlying filesystem *may* not support it.
> 
> What's to say that ext4 (or whatever) won't support named streams, but
> still allow ':'? Your solution as it stands would break in that situation
> (assuming I've not missed something :)

The filesystem, when registering that it supports the "named streams"
namespace, could specify its preferred delimiter to the VFS as well.
Ext4 could use /directory/file/stream, and NTFS could use
/directory/file:stream.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
