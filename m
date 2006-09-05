Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWIEVBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWIEVBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbWIEVBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:01:22 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:5352 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422649AbWIEVBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:01:21 -0400
Subject: Re: Linux 2.6.18-rc6
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060905122656.GA3650@aepfle.de>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
	 <20060905122656.GA3650@aepfle.de>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 16:01:06 -0500
Message-Id: <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 14:26 +0200, Olaf Hering wrote:
> <4>Machine check in kernel mode.
> <4>Caused by (from SRR1=49030): Transfer error ack signal
> <4>Oops: Machine check, sig: 7 [#1]
[...]
> <4> scsi0: PCI error Interrupt at seqaddr = 0x8

Is this actually a PCI bus error?  In which case it's probably the
ahc_inb(,SBLKCTL) of ahc_linux_get_signalling().  Can you verify this?
And what happens when you try to cat /proc/scsi_host/host<n>/signalling
for this card?

James


