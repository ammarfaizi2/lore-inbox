Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTKMPoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTKMPoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:44:10 -0500
Received: from [212.35.254.18] ([212.35.254.18]:20959 "EHLO mail2.midnet.co.uk")
	by vger.kernel.org with ESMTP id S264319AbTKMPoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:44:07 -0500
Date: Thu, 13 Nov 2003 15:43:14 +0000
From: Tim Kelsey <mn@midnet.co.uk>
To: Michael Schroeder <mls@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm3 initrd strangeness
Message-Id: <20031113154314.469030ba.mn@midnet.co.uk>
In-Reply-To: <20031113144738.GA18329@suse.de>
References: <20031113135245.128ec5e0.mn@midnet.co.uk>
	<20031113144738.GA18329@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanx,

My image was too big, i have now changed the initrd size in the kernel config as you said and it works perfectly now.

Thanx very much for your help

Tim Kelsey

On Thu, 13 Nov 2003 15:47:38 +0100
Michael Schroeder <mls@suse.de> wrote:

> On Thu, Nov 13, 2003 at 01:52:45PM +0000, Tim Kelsey wrote:
> > I am experiencing problems with 2.6.0-test9-mm3 and initrd ramdisks
> > I have support for ramdisks and initrd compiled directly into the kernel and have an initrd image gzipped and placed in /boot called initrd-crypt.gz
> > 
> > When booting off a 2.4.22 kernel the image is loaded and linuxrc is executed perfectly but with a 2.6.0-test9-mm3 kernel i get the following msg at boot time
> > 
> > 	RAMDISK: Compressed image found at block 0
> > 	RAMDISK: incomplete Write (-1 != 32768) 4194304
> > 
> > Any comments, advice, opinions greatly appreciated also if someone could explain what those numbers actually mean i would be very grateful 
> 
> Seems like your ramdisk is full, the default size is 4096k.
> Change the CONFIG_BLK_DEV_RAM_SIZE parameter or boot with
> ramdisk_size=<value>.
> 
> Cheers,
>   Michael.
> 
> -- 
> Michael Schroeder                                   mls@suse.de
> main(_){while(_=~getchar())putchar(~_-1/(~(_|32)/13*2-11)*13);}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
