Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279794AbRJ3NrS>; Tue, 30 Oct 2001 08:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279883AbRJ3NrJ>; Tue, 30 Oct 2001 08:47:09 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:20564 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S279794AbRJ3Nq4>; Tue, 30 Oct 2001 08:46:56 -0500
Date: Tue, 30 Oct 2001 13:46:48 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2 x process stuck in D state
Message-ID: <20011030134648.A7850@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
X-OS: Linux grobbebol 2.4.13 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing with an old irix cd that I couldn't mount at first.

people told me that there have been some changes lately in the kernel
regarding cd's etc. 

anyways.

mout -t efs /dev/sr0 /cdrom didn't work and what _did_ work, was 

mount -t efs /dev/sr0 /cdrom -o loop or something along the line. I
could ls the cd fine.

there was a RELEASE.INFO on the cd so let's take a look at it.

oops. bad idea :

root 7429  0.0  0.0     0    0 ?   SW<  13:02   0:00 [loop0]
root 7439  0.0  0.0  1652  712 ?   D    13:04   0:00 less RELEASE.info
root 7445  0.0  0.1  1800  972 ?   D    13:04   0:00 file RELEASE.info

so the cdrom can't be umounted; I can't kill the processes.

is this a bug, or supposed to be this way ? :-)

-- 
Grobbebol's Home                      |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel          | Use your real e-mail address   /\
Linux 2.4.13 (apic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
