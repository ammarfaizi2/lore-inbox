Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315199AbSEFVME>; Mon, 6 May 2002 17:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315201AbSEFVMD>; Mon, 6 May 2002 17:12:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41231 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315199AbSEFVMC>;
	Mon, 6 May 2002 17:12:02 -0400
Message-ID: <3CD6F166.3853AF05@zip.com.au>
Date: Mon, 06 May 2002 14:11:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <reality@delusion.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ext3 errors with 2.4.18
In-Reply-To: <3CD6AE7A.FBEB5726@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Hi,
> 
> With Linux 2.4.18, I'm getting multiple of the following error:
> 
> EXT3-fs error (device ide0(3,2)): ext3_readdir: bad entry in directory #1966094:
> rec_len % 4 != 0 - offset=0, inode=3180611420, rec_len=53134, name_len=138
> 
> Can someone decipher this?
> 

That's random junk.  Heaven knows.  It could have come
from anywhere in the kernel.  Including ext3, of course.

When you see this sort of thing you should immediately
take the machine down, because the corruption could be
only in-memory. The longer the machine stays up, the
better the chance that the corruption will go to disk.

And with ext3, the best way to take the machine down
is to pull the power plug.  Normal shutdown tools will
sync the disks, which you don't want to happen.

Then reboot with `init=/bin/sh' and force a fsck against
all filesystems.

-
