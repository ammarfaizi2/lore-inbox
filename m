Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268679AbUH3Rb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268679AbUH3Rb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268646AbUH3Rb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:31:56 -0400
Received: from main.gmane.org ([80.91.224.249]:23969 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268582AbUH3R2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:28:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Marc_Str=E4mke?= <marcstraemke.work@gmx.net>
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the
     IDE bus)
Date: Mon, 30 Aug 2004 19:31:12 +0200
Message-ID: <cgvo40$t0d$2@sea.gmane.org>
References: <cgs2c1$ccg$1@sea.gmane.org> <4131DC5D.8060408@redhat.com> <cgsuq2$7cb$1@sea.gmane.org> <41326FE1.2050508@redhat.com> <20040830010712.GC12313@logos.cnet> <cguj7n$gur$1@sea.gmane.org> <41333879.2040902@redhat.com> <cgvi5l$t0d$1@sea.gmane.org> <41335F8B.3000207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508ea078.dip.t-dialin.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
In-Reply-To: <41335F8B.3000207@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> <snip<
> 
> 1) older SanDisk cards are detected as CFA devices and are working, but 
> not bootable.
> 
> 2) newer SanDisk cards are detected as ATA disks, and are bootable as 
> such, but do not seem to be operating correctly (the aforementioned ide 
> errors).
> 
> 
> Is this correct?

Not fully, actually both are bootable, but the second one gets 
read/write errors after booting, and when accessed after booting from 
another boot device (NFS)

for the other points, actually both cards are used in the same adapter 
hardware. I can switch both cards in ONE system, and the error only 
appears with the newer card.

I found some other subtlety, in the dmesg of the nonworking card there 
is a message:

hdb: C/H/S=0/0/0 from BIOS ignored

which doesnt appear with the working card, so the card is already 
treated differently by the bios, or the different information from the 
bios somehow interfers with hardware probing? (just speculating on this 
point)
I will do some more tests and tell you what i find out.

