Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWGBQE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWGBQE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 12:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWGBQE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 12:04:28 -0400
Received: from xenotime.net ([66.160.160.81]:56194 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932510AbWGBQE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 12:04:28 -0400
Date: Sun, 2 Jul 2006 09:07:13 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen.Clark@seclark.us, linux-kernel@vger.kernel.org
Subject: Re: isa_memcpy_fromio
Message-Id: <20060702090713.bd3a2e68.rdunlap@xenotime.net>
In-Reply-To: <1151834671.14346.5.camel@localhost.localdomain>
References: <44A732E3.10202@seclark.us>
	<1151834671.14346.5.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jul 2006 11:04:31 +0100 Alan Cox wrote:

> Ar Sad, 2006-07-01 am 22:43 -0400, ysgrifennodd Stephen Clark:
> > Hello,
> > 
> > what has isa_memcpy_fromio() changed to in kernel 2.6.17 from 2.6.16
> 
> It was always meant as a transition interface (although it survived
> incredibly long). All code that uses the ioremap is unaffected: ie
> 
> 	foo = ioremap(isa_addr, len);
> 	memcpy_fromio(foo + bar, buf, len2)

Stephen,
There were only 3 drivers in 2.6.16 that used isa_memcpy_fromio().
You can look at how they were changed for 2.6.17.

drivers/net/hp100.c and hp-plus.c
drivers/scsi/g_NCR5380.c

---
~Randy
