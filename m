Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTDUOSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 10:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbTDUOSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 10:18:21 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:25608 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261294AbTDUOSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 10:18:06 -0400
Date: Mon, 21 Apr 2003 15:30:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pierfrancesco Caci <pf@tippete.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: booting 2.5.68 with root on software raid and devfs?
Message-ID: <20030421153007.A1802@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierfrancesco Caci <pf@tippete.net>, linux-kernel@vger.kernel.org
References: <87smsceyim.fsf@home.tippete.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87smsceyim.fsf@home.tippete.net>; from ik5pvx@home.tippete.net on Mon, Apr 21, 2003 at 04:05:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 04:05:53PM +0200, Pierfrancesco Caci wrote:
> root@penny:~ # head /etc/lilo.conf
> #disk=/dev/hda
> # bios=0x80
> #disk=/dev/hdd
> # bios=0x81
> boot=/dev/md0
> root=/dev/md0
> raid-extra-boot=/dev/hda,/dev/hdd
> #compact
> #linear
> lba32

No idea how lilo maps all this to a kernel command line, but
in 2.5 you need to pass the devfs names to the kernel if using devfs,
not the old ones.

