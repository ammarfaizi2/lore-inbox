Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWIEWU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWIEWU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 18:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWIEWU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 18:20:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:4800 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965210AbWIEWU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 18:20:56 -0400
Subject: Re: Linux 2.6.18-rc6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Olaf Hering <olaf@aepfle.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
	 <20060905122656.GA3650@aepfle.de>
	 <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 08:20:37 +1000
Message-Id: <1157494837.22705.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 16:01 -0500, James Bottomley wrote:
> On Tue, 2006-09-05 at 14:26 +0200, Olaf Hering wrote:
> > <4>Machine check in kernel mode.
> > <4>Caused by (from SRR1=49030): Transfer error ack signal
> > <4>Oops: Machine check, sig: 7 [#1]
> [...]
> > <4> scsi0: PCI error Interrupt at seqaddr = 0x8
> 
> Is this actually a PCI bus error?  In which case it's probably the
> ahc_inb(,SBLKCTL) of ahc_linux_get_signalling().  Can you verify this?
> And what happens when you try to cat /proc/scsi_host/host<n>/signalling
> for this card?

Yes, it's a PCI error.

Ben.


