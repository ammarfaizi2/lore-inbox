Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTLURVt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 12:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLURVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 12:21:49 -0500
Received: from bay8-dav13.bay8.hotmail.com ([64.4.26.117]:2309 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263472AbTLURVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 12:21:48 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Sun, 21 Dec 2003 18:21:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcPH4MNRXBvSI+pTTmm2mInozEX+ewABbKlg
In-Reply-To: <3FE5CB0E.6060702@comcast.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV13E2eDEo42p00003756@hotmail.com>
X-OriginalArrivalTime: 21 Dec 2003 17:21:47.0170 (UTC) FILETIME=[E993F820:01C3C7E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will try to do that now. Do you think this can have anything to do with me
actually having a rather large root partition (76GB)? I will try with two
33GB partitions this time (it might have something to do with it - but on
the other hand it is working working with the Debian pre-compiled kernel).

Well, let's see what I find out. I'll keep you posted.

/Nicke 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Walt H
Sent: den 21 december 2003 17:32
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)

Nicklas Bondesson wrote:
> Nopes, I get the kernel panic before the driver loads or when it does, 
> however I'm not seeing any ataraid driver message at all. This is 
> really strange I think. The only thing that has changed in my setup 
> are the harddrives. I really need to get this working. Do you have any 
> suggestions what-so-ever what to do? I really appreciate your help on
this.
> 
> /Nicke
> 

Well, since you're using raid1, you should be able to pass a root=/dev/hda1
(or whatever your / is located) using the same kernel and at least boot
using this kernel. Then maybe you can use dmesg etc.. to see what the driver
is actually doing. From your original post, it looks like you're using Lilo,
so you'll need to boot using the old kernel first and change the lilo entry.

-Walt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
