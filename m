Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285548AbRLYOKx>; Tue, 25 Dec 2001 09:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285566AbRLYOKc>; Tue, 25 Dec 2001 09:10:32 -0500
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:50961 "EHLO
	manty.net") by vger.kernel.org with ESMTP id <S285556AbRLYOKX>;
	Tue, 25 Dec 2001 09:10:23 -0500
Date: Tue, 25 Dec 2001 15:10:19 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: jlladono@pie.xtec.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels, big ide disks and old bios
Message-ID: <20011225141019.GA3092@man.beta.es>
In-Reply-To: <3C285B40.91A83EC7@jep.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C285B40.91A83EC7@jep.dhis.org>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bios only supports disks up to 32 Gb.
> hard disk is 60 Gb.

What I'm using is change the geometry after the boot and before any
partition besides root is mounted, I do this at the beginning of
checkroot.sh by calling "/sbin/setmax -d 0 /dev/hda" but you can do it on
your own script or where ever you want, just taking care that it is done
befor any FS that goes above the 32gigs is accessed.

Setmax is a small program that I downloaded from the net, sorry, I don't
remember where did I download it from or his author, but it was posted to
this list some time ago, I have a version for the 2.4 kernel at
ftp.manty.net/linux/programs/setmax.c

This works ok for me, of course you can have other solutions.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
