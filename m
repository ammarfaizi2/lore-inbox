Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWFTIF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWFTIF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWFTIF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:05:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58275 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964998AbWFTIFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:05:24 -0400
Subject: RE: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver
	for PDC202XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik@echohome.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAIdWvHE4LIdGgJWKcd2w9I8BAAAAAA==@EchoHome.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAIdWvHE4LIdGgJWKcd2w9I8BAAAAAA==@EchoHome.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jun 2006 09:20:27 +0100
Message-Id: <1150791627.11062.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-19 am 18:18 -0400, ysgrifennodd Erik Ohrnberger:
> Regardless, count me as another one of the interested parties for a cure.
> I've read the thread, and will prepare two current kernels, one using the
> PDC202XX_NEW and one using the PDC202XX_OLD configuration options.  I'm
> hoping that the PDC202XX_OLD will also resolve this issue.

Bartlomiej is the old IDE layer maintainer. I would direct any enquiries
to him about those drivers.

> Any further advice on how to work around this would be greatly appreciated.

2.6.17 with the libata pata patch from
http://zeniv.linux.org.uk/~alan/IDE has a Promise driver for the PDC
20268 and higher that was written by Albert Lee. There is also a test
driver for the older chips (20265 etc).

To try that build 2.6.17 with the patch and then say "N" to CONFIG_IDE,
"Y" to the SATA options under SCSI and the right controller. It will
move your disks to /dev/sda /dev/sdb etc as it uses the SCSI layer.

Alan

