Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbRFSNwZ>; Tue, 19 Jun 2001 09:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbRFSNwP>; Tue, 19 Jun 2001 09:52:15 -0400
Received: from [199.111.154.8] ([199.111.154.8]:62985 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S262614AbRFSNwD>; Tue, 19 Jun 2001 09:52:03 -0400
Message-ID: <3B2F5BEC.A94F33A3@linuxjedi.org>
Date: Tue, 19 Jun 2001 10:04:28 -0400
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexandr Andreev <andreev@niisi.msk.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Using cramfs as root filesystem on diskless machine
In-Reply-To: <3B2A0F05.6050902@niisi.msk.ru> <3B2A538A.BA62148A@linuxjedi.org> <3B2F5282.30602@niisi.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandr Andreev wrote:
> 
> David L. Parsley wrote:
> 
> >Mathias Killian wrote a patch to allow cramfs initrd's, see:
> >http://www.cs.helsinki.fi/linux/linux-kernel/2001-01/1064.html
> >
> Thank you. I applied this patch, and recompiled my kernel.
> All works fine, if the size of root filesystem less than 4096Kb. But
> when i create
> an image of root filesystem which size is bigger than 4096Mb, the kernel
> said:
> ...
> RAMDISK driver initialized: 16 RAM disks of 4096K size 4096 blocksize
                                              ^^^^^
You also need to give the kernel 'ramdisk_size=XXXX'.  I've used
larger cramfs initrd's with no problem, but the kernel has to make
larger ramdisks.  By editing rd.c, you can make this stuff default.

regards,
	David
-- 
David L. Parsley
Network Administrator, Roanoke College
"If I have seen further it is by standing on ye shoulders of
Giants."
--Isaac Newton
