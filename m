Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWG0RZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWG0RZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWG0RZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:25:37 -0400
Received: from [212.33.185.90] ([212.33.185.90]:41483 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751836AbWG0RZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:25:37 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: patch for Documentation/initrd.txt?
Date: Thu, 27 Jul 2006 20:26:57 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607272026.57695.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Horsley wrote:
>
> I spend hours the other day trying to examine a fedora core 5
> initrd file in the mistaken belief that the Documentation/initrd.txt
> file might contain relevant information :-). It didn't, but
> many web searches later I finally discovered the new key
> to decrypting initrd files. Would it be possible to add the
> attached patch (or a better one if someone can explain things
> in more detail) to the initrd.txt file to avoid future
> confusion? Thanks.
>
> ["initrd-doc-patch" (initrd-doc-patch)]
>
> --- linux-2.6.17.7/Documentation/initrd.txt     2006-07-27
> 08:49:30.000000000 -0400 +++ linux-2.6.17.7/Documentation/initrd.txt    
> 2006-07-27 09:02:04.000000000 -0400 @@ -73,6 +73,22 @@
>      initrd is mounted as root, and the normal boot procedure is followed,
>      with the RAM disk still mounted as root.
>
> +Compressed cpio images
> +----------------------
> +
> +Recent kernels have support for populating a ramdisk from a compressed
> cpio +archive, on such systems, the creation of a ramdisk image doesn't
> need to +involve special block devices or loopbacks, you merely create a
> directory on +disk with the desired initrd content, cd to that directory,
> and run (as an +example):
> +
> +find . | cpio --quiet -c -o | gzip -9 -n > /boot/imagefile.img
> +
> +Examining the contents of an existing image file is just as simple:
> +
> +mkdir /tmp/imagefile
> +cd /tmp/imagefile
> +gzip -cd /boot/imagefile.img | cpio -imd --quiet
>
>  Installation
>  ------------

Thanks for your very useful docPatch!

OT, but your docPatch made me think of another way to init the kernel; via 
tmpfs, i.e. initTmpFS.

Can anybody see how that could be useful?

Thanks!

--
Al

