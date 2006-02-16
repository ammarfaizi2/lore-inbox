Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWBPKgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWBPKgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 05:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWBPKgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 05:36:22 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:18115 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1751252AbWBPKgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 05:36:21 -0500
Date: Thu, 16 Feb 2006 11:36:19 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Charles-Edouard Ruault <ce@ruault.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
Message-ID: <20060216103619.GI30182@vanheusden.com>
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org>
	<43F44978.2050809@ruault.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F44978.2050809@ruault.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Thu Feb 16 09:55:03 CET 2006
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From what i understand it will fix the problem only if the drive is in
> PIO mode, which is the case for  Folkert van Heusden, who reported the
> same BUG output.
> However it does not appear that my cdrom drives are using PIO, from the
> logs i have they're supposed to use DMA :
> >Feb 12 19:37:12 ruault kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive,2048kB Cache, DMA
> > Feb 12 19:37:12 ruault kernel: Uniform CD-ROM driver Revision: 3.20
> > Feb 12 19:37:12 ruault kernel: hdd: ATAPI 32X DVD-ROM DVD-R CD-R/RW
> > drive, 2048kB Cache, UDMA(33)
> sudo /sbin/hdparm -i /dev/hdc
> /dev/hdc:
>  DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2

Try /sbin/hdparm -d /dev/hdc
and see if it returns "using_dma = 1 (on)".
I noticed that altough -i says using dma, that -d tells me it really is
off.


Folkert van Heusden

-- 
www.biglumber.com <- site where one can exchange PGP key signatures 
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
