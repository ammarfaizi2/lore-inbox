Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVIFULp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVIFULp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVIFULp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:11:45 -0400
Received: from penobscot.web.itd.umich.edu ([141.211.144.185]:29094 "EHLO
	penobscot.web.itd.umich.edu") by vger.kernel.org with ESMTP
	id S1750855AbVIFULo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:11:44 -0400
Message-ID: <20050906161132.tvjp84734084kg0k@engin.mail.umich.edu>
Date: Tue, 06 Sep 2005 16:11:32 -0400
From: mreuther@umich.edu
To: David Sanchez <david.sanchez@lexbox.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATAII 150 TX (PDC 20579) & PATA/SATA port problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-Remote-Browser: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1;
	.NET CLR 1.1.4322)
X-IMP-Server: 141.211.144.247
X-Originating-IP: 71.4.119.66
X-Originating-User: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2005-09-06 at 12:51:47, you wrote:

>Hi,
>
>I'm using the linux 2.6.13 (from www.linux-mips.org) containing the
>libata patch (2.6.13-rc7-libata1.patch.bz2) on an AMD DBAu1550 (mips32).
>I've connected a HDD to the pata port of my PDC 20579 controller.
>Unfortunately, it doesn't work. Here a part of the boot messages:

[snip]

>I've try to connect a HDD on a SATA port and the problem still appears
>:(. More when I try the 2.6.10 kernel with the corresponding libata
>patch it, works !
>
>Does somebody have such a behaviour ?
>Please help me ! What can I do to make the kernel2.6.13 works with my
>promise controller ?
>
>Thanks
>David

Hi, David. I think I have the same problem with a similar card, the SATA150
TX2plus. The sata_promise module sees the SATA ports, but not the PATA port.

Promise made up a driver called pdc-ultra (not based o ftlib.o) that worked with
2.4 kernels (I could see the PATA drive as a SCSI drive), but it spits back
"unresolved symbols" errors with 2.6. Promise is useless for tech support on
this.

Jeff Garzik says something on the libata website about a patch for preliminary
support of PATA on Promise SATA, but I haven't tried it out.

Matt
