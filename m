Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTLVAFw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 19:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTLVAFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 19:05:51 -0500
Received: from bay8-dav35.bay8.hotmail.com ([64.4.26.92]:7693 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264266AbTLVAFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 19:05:50 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Mon, 22 Dec 2003 01:05:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <3FE5CB0E.6060702@comcast.net>
Thread-Index: AcPH4MNRXBvSI+pTTmm2mInozEX+ewAPWmRA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV35IMKT7Fvnj0000fb07@hotmail.com>
X-OriginalArrivalTime: 22 Dec 2003 00:05:49.0339 (UTC) FILETIME=[5B0966B0:01C3C81F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now I'm sucessfully booting my system with the 2.4.23 kernel using only one
of the drives (hde). There is not a single line in the logs that says
anything about the Promise ATARAID driver is beeing fired up, so my guess is
that it doesn't load if no one is calling on it. When I try to boot from the
RAID it dies right after the "NET4: Unix domain sockets 1.0/SMP for Linux"
message. I think it's when the ATARAID driver is about to fire up. I have no
idea at all what to do now. It must have something to do with the hard
drives since this is the only thing that has changed. Maybee I'm missing
some important kernel setting option or so? (I don't think so, but one never
know for sure). Also what have changed in the Promise / ATARAID since
2.4.18?.

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
