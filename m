Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTISPYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 11:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTISPYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 11:24:37 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:45472 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP id S261613AbTISPYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 11:24:35 -0400
Message-ID: <3F6B1FAF.89C9F5F4@pp.inet.fi>
Date: Fri, 19 Sep 2003 18:24:31 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kovacs Gabor <kgabor@BOLYAI1.ELTE.HU>
CC: linux-kernel@vger.kernel.org
Subject: Re: Loop device and smbmount: I/O error
References: <1063914356.1639.34.camel@warp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kovacs Gabor wrote:
> I've tried to mount an ext2 filesystem image (ca. 1GB) stored on a WIN
> computer via the loop device under 2.4.22:
> 
> (Initially the file scratch2.img is filled with 0s.)
> 
> #smbmount //win02/scratch /pro -o username=sambadisk,workgroup=MYDOMAIN
> #losetup /dev/loop0 /pro/scratch2.img
> #mke2fs /dev/loop0
> #mount /dev/loop0 /scratch -t ext2
> 
> #cp -r linux-2.4.22 /scratch
> cp: cannot create directory `/scratch/linux-2.4.22/drivers/video/sis':
> Input/output error
> cp: cannot create directory `/scratch/linux-2.4.22/drivers/video/aty':
> Input/output error

This bug should be fixed in loop-AES version of loop, here:

http://loop-aes.sourceforge.net/loop-AES/loop-AES-v1.7e.tar.bz2

Can you try again with that version?

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

