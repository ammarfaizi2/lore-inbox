Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266942AbRGMWkV>; Fri, 13 Jul 2001 18:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbRGMWkL>; Fri, 13 Jul 2001 18:40:11 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:28688 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S266942AbRGMWj7>; Fri, 13 Jul 2001 18:39:59 -0400
Message-Id: <200107132239.f6DMduU20247@aslan.scsiguy.com>
To: stefan@jaschke-net.de
cc: Luc Lalonde <llalonde@giref.ulaval.ca>,
        "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec SCSI driver lockups 
In-Reply-To: Your message of "Fri, 13 Jul 2001 23:55:10 +0200."
             <01071323551000.30655@antares> 
Date: Fri, 13 Jul 2001 16:39:56 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>(2) I tried to disable tagged command queuing or set "tag_info" to 
> more moderate values since I noticed that the queue length was set 
> to an incredible length of 253. However, the new driver from Adaptec 
> just ignores the old kernel parameters.

Hmm.  The tag_info stuff seems to work for me.  The new driver certainly
is not supposed to ignore these parameters.

BTW, the tag depth is merely an upper bound.  The driver will dynamically
determine the abilities of each device and throttle accordingly.  Your
DVD drive probably doesn't even support tagged queing, so your custom
kernel with a lower tag count will only affect the HD.

--
Justin
