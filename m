Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTKMOrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 09:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTKMOrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 09:47:41 -0500
Received: from ns.suse.de ([195.135.220.2]:8378 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264304AbTKMOrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 09:47:40 -0500
Date: Thu, 13 Nov 2003 15:47:38 +0100
From: Michael Schroeder <mls@suse.de>
To: Tim Kelsey <mn@midnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm3 initrd strangeness
Message-ID: <20031113144738.GA18329@suse.de>
References: <20031113135245.128ec5e0.mn@midnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113135245.128ec5e0.mn@midnet.co.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 2048G/BBC5057B
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 01:52:45PM +0000, Tim Kelsey wrote:
> I am experiencing problems with 2.6.0-test9-mm3 and initrd ramdisks
> I have support for ramdisks and initrd compiled directly into the kernel and have an initrd image gzipped and placed in /boot called initrd-crypt.gz
> 
> When booting off a 2.4.22 kernel the image is loaded and linuxrc is executed perfectly but with a 2.6.0-test9-mm3 kernel i get the following msg at boot time
> 
> 	RAMDISK: Compressed image found at block 0
> 	RAMDISK: incomplete Write (-1 != 32768) 4194304
> 
> Any comments, advice, opinions greatly appreciated also if someone could explain what those numbers actually mean i would be very grateful 

Seems like your ramdisk is full, the default size is 4096k.
Change the CONFIG_BLK_DEV_RAM_SIZE parameter or boot with
ramdisk_size=<value>.

Cheers,
  Michael.

-- 
Michael Schroeder                                   mls@suse.de
main(_){while(_=~getchar())putchar(~_-1/(~(_|32)/13*2-11)*13);}
