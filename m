Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUCQW1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUCQW1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:27:18 -0500
Received: from wacom-nt2.wacom.com ([204.119.25.126]:16398 "EHLO
	wacom_nt2.WACOM.COM") by vger.kernel.org with ESMTP id S262119AbUCQW0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:26:05 -0500
Message-ID: <28E6D16EC4CCD71196610060CF213AEB065C23@wacom-nt2.wacom.com>
From: Ping Cheng <pingc@wacom.com>
To: "'Vojtech Pavlik'" <vojtech@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Wacom USB driver patch
Date: Wed, 17 Mar 2004 14:24:20 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the history. Patches for wacom.c in 2.4 was majorly modified by John
Joganic. Specially, the reset thread was added by John to deal with the case
when the tablet is set/reset to HID mode. Otherwise the driver will have to
be reloaded. The code was tested by users. Patches for wacom.c in 2.6 was
made by myself.

The reason I didn't add the reset thread to 2.6 patch was because I don't
know exactly how to do it in 2.6 and I didn't find proper examples from
other device drivers in 2.6. Basically, I don't want to introduce any new
"feature" before I can convince myself.

The reason I didn't remove the reset thread code in 2.4 was because it was
tested by many users and there are no negative feedbacks. 

So, we need the reset thread. Please let me know the proper approach to
implement this feature in 2.4 and 2.6. I'll update the patches accordingly.

Ping

-----Original Message-----
From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
Sent: Wednesday, March 17, 2004 12:37 PM
To: Pete Zaitcev
Cc: Ping Cheng; linux-kernel@vger.kernel.org
Subject: Re: Wacom USB driver patch


On Wed, Mar 17, 2004 at 09:29:59AM -0800, Pete Zaitcev wrote:

> Dear Ping,
> 
> Vojtech posted your 2.6 patch to linux-kernel yesterday, so I examined 
> it
> (Subject: [PATCH 32/44] Update of Wacom driver from Ping Cheng (from
Wacom)).
> Unlike the 2.4 version, it does not feature a reset thread. Please tell
> me why that thread was required in 2.4.
> 
> Or perhaps it was present in your original submission which I lost and 
> Vojtech removed that element of the patch?

I didn't remove it - it was not present in the 2.6 patch.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
