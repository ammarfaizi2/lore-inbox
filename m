Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284290AbRLEQlY>; Wed, 5 Dec 2001 11:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284469AbRLEQlO>; Wed, 5 Dec 2001 11:41:14 -0500
Received: from quark.didntduck.org ([216.43.55.190]:15116 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S284290AbRLEQlF>; Wed, 5 Dec 2001 11:41:05 -0500
Message-ID: <3C0E4E1A.9A6D5E64@didntduck.org>
Date: Wed, 05 Dec 2001 11:40:58 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linuxlist@visto.com
CC: linux-kernel@vger.kernel.org
Subject: Re: newly compiled kernel no .img file
In-Reply-To: <3C091F550002B98E@smtparch.vistocorporation.com> (added by
		    postmaster@smtparch.vistocorporation.com)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rohit prasad wrote:
> 
> Hi,
> 
>  I have recompiled the linux 2.4.7-10 kernel to get ntfs readonly support.
> 
>  this is what I entered in the lilo.conf in the fllowing order,
> 
>  NEWLY COMPILED KERNEL IMAGE
>  OLD KERNEL IMAGE
>  WINDOWS
> 
> 
>  image=/boot/wmlinux-2.4.7-10
>         label=xunil
>         read-only
>         root=/dev/hda2
>  image=/boot/vmlinuz-2.4.7-10old
>         label=linux
>         initrd=/boot/initrd-2.4.7-10.img
>         read-only
>         root=/dev/hda2
> other=/dev/hda1
>         optional
>         label=windows
> 
> If you notice the first declaration of image the
> "initrd=/boot/initrd-2.4.7-10.img" is not present . Of course I removed it so that there would be no kernel panic and I am able to boot into the new kernel (xunil).
> What I want to know is what is this .img file why is it required in the original kernel compilation and not in the newer .

Your distribution put that there so that it can use modules for drivers
that are required to mount the root filesystem (ie. SCSI, fs driver,
etc.).  If you build your own kernel, those drivers should be built
non-modular, therefore you won't need an initrd.

--

				Brian Gerst
