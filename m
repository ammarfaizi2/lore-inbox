Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbRFYJGi>; Mon, 25 Jun 2001 05:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbRFYJG2>; Mon, 25 Jun 2001 05:06:28 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:55313 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262702AbRFYJGS>; Mon, 25 Jun 2001 05:06:18 -0400
Message-ID: <3B36FE99.1B8AE381@idb.hist.no>
Date: Mon, 25 Jun 2001 11:04:25 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: John Nilsson <pzycrow@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Nilsson wrote:
[everything else answered by others]

> 8: A way to change kernel without rebooting. I have no diskdrive or cddrive
> in my laptop so I often do drastic things when I install a new distribution.

Well, don't do drastic things then, if that cause problems!

My machines have both diskette and cdrom - but I _don't_ use them when
changing 
kernels.  Why should you?  Here is a procedure for painless kernel
change.
It includes a reboot but that is not a problem:

1. Get the new kernel, i.e. compile it.
2. cp the bzImage to /boot (or wherever you want it.)  DON'T overwrite
   the previous kernel image, you will want to keep it around.
3. If using lilo, modify /etc/lilo.conf to load the new kernel.
   Do this by _adding_ image=/boot/new_kernel_bzimage, not by changing
   existing lines.  This keeps the old kernel around in case the new
   one have trouble.
4. run lilo
5. reboot.

The new kernel should come up.  (If the old comes up you either
forgot (4), or you have the lilo.conf entries in a wrong order.
Int the latter case press shift furing boot and select the
correct kernel manually.  You may correct lilo.conf later.

If the new kernel loads but crash, do reboot and use the above
mentioned shift-trick to select the old kernel.  Then remove
the broken kernel from lilo.conf and re-run lilo.  

As you see, no need for CD's or floppies when changing kernels,
even if the new kernel fails somehow.

Helge Hafting
