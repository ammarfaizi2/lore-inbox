Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbREFHgV>; Sun, 6 May 2001 03:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133076AbREFHgA>; Sun, 6 May 2001 03:36:00 -0400
Received: from [24.70.141.118] ([24.70.141.118]:35320 "EHLO asdf.capslock.lan")
	by vger.kernel.org with ESMTP id <S132392AbREFHft>;
	Sun, 6 May 2001 03:35:49 -0400
Date: Sun, 6 May 2001 03:35:34 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4 add suffix for uname -r
In-Reply-To: <3024.989133345@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.33.0105060334390.1549-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2001, Keith Owens wrote:

>Date: Sun, 06 May 2001 17:15:45 +1000
>From: Keith Owens <kaos@ocs.com.au>
>To: linux-kernel@vger.kernel.org
>Content-Type: text/plain; charset=us-ascii
>Subject: [patch] 2.4 add suffix for uname -r
>
>A frequent requirement is to rename vmlinuz-2.x.y to 2.x.y-old or
>2.x.y.save to preserve a working kernel.  But renaming the image does
>not change the value of uname -r so it still tries to use modules
>2.x.y, which defeats the purpose of saving an working kernel.
>
>Normally I would say that this is a user space problem but it requires
>finding every program that uses uname(2) and every script that uses
>uname -r and changing them, not practical (modutils, alsa, pciutils,
>/etc/rc.d, mkinitrd etc.).  Instead this small patch to the kernel adds
>the boot time option unamersfx (uname -r suffix).  Rename a kernel
>image from 2.x.y to 2.x.y.foo, rename /lib/modules/2.x.y to 2.x.y.foo
>and boot with unamersfx=.foo to safely pick up the old kernel.
>
>Objects that "know" the value of uname -r that they were compiled with
>will not work with unamersfx.  Are there any?

I don't see how this patch is necessary when we have
"EXTRAVERSION" available.  Change EXTRAVERSION in your kernel
builds and it is totally a non issue.  No renaming of anything is
necessary.


------------------------------------------------------------------------
Signature poll:  I'm planning on getting a 12 or 16 port autosensing
10/100 ethernet switch soon for home use, and am interested in hearing
others recommendations on what to buy.  Cost isn't as important as is
functionality and quality.  Any suggestions appreciated.
------------------------------------------------------------------------

