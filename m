Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVF3AeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVF3AeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVF3AeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:34:11 -0400
Received: from free.hands.com ([83.142.228.128]:22453 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S262759AbVF3Adn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 20:33:43 -0400
Date: Thu, 30 Jun 2005 01:38:48 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: accessing loopback filesystem+partitions on a file
Message-ID: <20050630003848.GC8415@lkcl.net>
References: <20050628233335.GB9087@lkcl.net> <Pine.LNX.4.63.0506290228380.7125@alpha.polcom.net> <20050629015030.GG9566@lkcl.net> <42C2A1D5.D586E874@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C2A1D5.D586E874@users.sourceforge.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jari, thank you.

there are _loads_ of people with mad and bad solutions - why
are none of them easily accessible via oh say debian packages???

l.


On Wed, Jun 29, 2005 at 04:27:49PM +0300, Jari Ruusu wrote:
> Luke Kenneth Casson Leighton wrote:
> > such that it is possible to then subsequently do this:
> > 
> > fdisk /dev/loopblocka and
> > mkfs.ext2 /dev/loopblocka1
> > mount /dev/loopblocka1 -t ext2 /mnt/somewhere
> 
> Using attached image-mount script that is possible. Like this:
> 
>   ln -s image-mount image-losetup
>   fdisk filename
>        (remember to set correct cyl/head/sect before creating partitions)
>   ./image-losetup /dev/loop7 filename 2
>   mkfs.ext2 /dev/loop7
>   mount /dev/loop7 -t ext2 /mnt/somewhere
>   umount /mnt/somewhere
>   losetup -d /dev/loop7
> 
> or
> 
>   ./image-mount filename 2 /mnt/somewhere
>   umount /mnt/somewhere
> 
> Good news is that image-mount and image-losetup scripts get both size and
> offset of the partition right, so mkfs creates correct size file system. Bad
> news is that it only works with losetup and mount programs from loop-AES
> package. Google for "loop-AES" if you can't find it.
> 
> -- 
> Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD


-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
