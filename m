Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135764AbRAUH2T>; Sun, 21 Jan 2001 02:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135763AbRAUH2J>; Sun, 21 Jan 2001 02:28:09 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:3847 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135405AbRAUH16>;
	Sun, 21 Jan 2001 02:27:58 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101210727.f0L7RO3258994@saturn.cs.uml.edu>
Subject: Re: named streams, extended attributes, and posix
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Sun, 21 Jan 2001 02:27:24 -0500 (EST)
Cc: mmckinlay@gnu.org (Mo McKinlay), peter@cadcamlab.org (Peter Samuelson),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A686599.470272D6@holly-springs.nc.us> from "Michael Rothwell" at Jan 19, 2001 11:04:41 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell writes:
> ...
>> Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:

>>> The filesystem, when registering that it supports the "named streams"
>>> namespace, could specify its preferred delimiter to the VFS as well.
>>> Ext4 could use /directory/file/stream, and NTFS could use
>>> /directory/file:stream.
...
> Oh, undoubtedly.  But NTFS already disallows several characters
> in valid filenames.

NTFS allows all 16-bit characters in filenames, including 0x0000.
Nothing is disallowed. The NT kernel's native API uses counted
Unicode strings. The strings can be huge too, like 128 kB.

So there isn't _any_ safe delimiter.

Win32 will choke on 0x0000 and a few other things, allowing a
clever person to create apparently inaccessible files.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
