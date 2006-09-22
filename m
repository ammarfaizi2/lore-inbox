Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWIVNiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWIVNiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWIVNit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:38:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:6374 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932455AbWIVNis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:38:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IcQtvY8nedaxMABDYO31ty4JRY87yPK64fdG29JL2cZrsn1auZfJp8B8QqEMI4iEBOgTyVVBUTG6st2dL/VUJurS/rxadpH9ExRTBeOyOF5d5hJEF/cCvX6zI4LNefsd+dwgiLpsiS7rtfx4bZGeNUx6zRr0hSn7cYOt+peXb4I=
Message-ID: <bd0cb7950609220638r58e11076p3efa8e0bfd5b61ba@mail.gmail.com>
Date: Fri, 22 Sep 2006 09:38:47 -0400
From: "Tom St Denis" <tomstdenis@gmail.com>
To: "Daniel Drake" <dsd@gentoo.org>
Subject: Re: sky2 eth device with Gigabyte 965P-S3 motherboard
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bd0cb7950609220629i191683bq7b21fca3e04fafb1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bd0cb7950609200635qae3e0c6p3f7d776d33b50542@mail.gmail.com>
	 <4513D362.8030804@gentoo.org>
	 <bd0cb7950609220629i191683bq7b21fca3e04fafb1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Tom St Denis <tomstdenis@gmail.com> wrote:
> This won't be fixed as part of 2.6.18.x?  Looking at the source for
> the latest gentoo-sources in the 2.6.17 stream I don't see ID 4364 in
> the source for sky2.c [sky2_id_table[]].  So why is it detected and
> working there but not in 2.6.18?
>
> I'll try adding the device to the table and see what happens.

Adding the line to the table works now.  [yipee, I get proper SATA and
net now woot!]

May I request that someone insert that one line to drivers/net/sky2.c
before 2.6.19?

--- sky2.old	2006-09-22 21:34:36.000000000 +0000
+++ sky2.c	2006-09-22 21:28:03.000000000 +0000
@@ -121,6 +121,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4361) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4362) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4363) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4364) },
 	{ 0 }
 };

[yeah I know not a normal patch ... I'm also not a kernel developer...]

I'm still confused on how it works in 2.6.17 without the ID?

Thanks,
Tom
