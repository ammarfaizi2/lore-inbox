Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbTDUOwD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 10:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTDUOwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 10:52:03 -0400
Received: from host92-52.pool62211.interbusiness.it ([62.211.52.92]:12161 "EHLO
	penny.tippete.net") by vger.kernel.org with ESMTP id S261302AbTDUOwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 10:52:02 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: booting 2.5.68 with root on software raid and devfs?
Reply-To: Pierfrancesco Caci <pf@tippete.net>
From: Pierfrancesco Caci <ik5pvx@home.tippete.net>
Date: Mon, 21 Apr 2003 17:04:01 +0200
In-Reply-To: <20030421153007.A1802@infradead.org> (Christoph Hellwig's
 message of "Mon, 21 Apr 2003 15:30:07 +0100")
Message-ID: <87k7dn6gf2.fsf@home.tippete.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <87smsceyim.fsf@home.tippete.net>
	<20030421153007.A1802@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

    > On Mon, Apr 21, 2003 at 04:05:53PM +0200, Pierfrancesco Caci wrote:
    >> root@penny:~ # head /etc/lilo.conf
    >> #disk=/dev/hda
    >> # bios=0x80
    >> #disk=/dev/hdd
    >> # bios=0x81
    >> boot=/dev/md0
    >> root=/dev/md0
    >> raid-extra-boot=/dev/hda,/dev/hdd
    >> #compact
    >> #linear
    >> lba32

    > No idea how lilo maps all this to a kernel command line, but
    > in 2.5 you need to pass the devfs names to the kernel if using devfs,
    > not the old ones.

Yep. Passing /dev/md/0 did it, and I'm now stuck with my partitions on
LVM that I don't know how to mount... Ahh, the bleeding edge :-)

Thanks :)

Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.21-pre7 #1 Sat Apr 12 09:12:33 CEST 2003 i686 GNU/Linux

