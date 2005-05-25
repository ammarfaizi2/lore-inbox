Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVEYSeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVEYSeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVEYSb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:31:27 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:54235 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261522AbVEYS0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:26:17 -0400
Date: Wed, 25 May 2005 14:26:13 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: initramfs
Message-ID: <20050525182613.GI23621@csclub.uwaterloo.ca>
References: <20050525174135.GA1098@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525174135.GA1098@animx.eu.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 01:41:35PM -0400, Wakko Warner wrote:
> I'm having problems with this.  I apparently have a cpio archive that the
> kernel likes.  I am starting via grub with basically:
> kernel /mykernel
> initrd /mycpiofile
> 
> At first, I got "can't mount root".  A little reading in main.c has it
> looking for /init  (shouldn't this be /bin/init instead?)
> 
> I moved my ./bin/init to . in my init filesystem tree and recreated the
> cpio.  my ./init script is a "#!/bin/busybox ash" script.
> 
> running cpio -tv, I see:
> ...
> -rwxr-xr-x   1 root     root       452508 May  5 14:33 bin/busybox
> ...
> -rwxr-xr-x   1 root     root         1328 May  9 15:46 init
> ...
> 
> Now I see a message saying:
> Kernel panic - not syncing: No init found.  Try passing init= option to kernel.
> 
> I did that.  According to the source, init= is overridden when /init exists.
> 
> I'd like to get off the initrd ramdisk style to save some more on space.
> 
> I assume it is populating properly since also I don't see the initial console
> warning message.
> 
> Kernel: vanilla 2.6.12-rc4 compiled with -Os with debian gcc 3.3.5-1

I didn't know you could use CPIO archives as initrd images.  I have used
gzip'd ext2 and cramfs (on Debian kernels only so far).  Actually I
didn't know cpio was even considered a filesystem (and hence would be
difficult to mount at all).

Len Sorensen
