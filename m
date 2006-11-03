Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWKCIH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWKCIH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWKCIH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:07:59 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:12224 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750855AbWKCIH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:07:58 -0500
Date: Fri, 3 Nov 2006 09:07:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Zachary Amsden <zach@vmware.com>
cc: Mark Lord <lkml@rtr.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 is problematic in VMware
In-Reply-To: <45480777.6070908@vmware.com>
Message-ID: <Pine.LNX.4.61.0611030906490.13091@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr>
 <45463B7D.8050002@vmware.com> <Pine.LNX.4.61.0610310857280.23540@yvahk01.tjqt.qr>
 <4547584F.6000702@rtr.ca> <Pine.LNX.4.61.0610311551370.6900@yvahk01.tjqt.qr>
 <45480777.6070908@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I see a large delay _before_:

(Yes, so do I)

> Calibrating delay using timer specific routine.. (lpj==
>
> The lpj value is 38x the host lpj host value.  Booting with lpj="some random
> number" removes the stall for me.  And finally, breaking into kernel in this
> stall period consistently shows EIPs in calibrate_delay in backtrace.
>
>> One can see that it pauses before calibration (already mentioned that) and
>> once again after NET: ... during IP init!? What's going on :(
>> 
>
> The NET: pause has always been there, I think it just becomes much more
> noticeable if the lpj value is 38x normal.
>
> Conclusion: you are getting bad lpj computation during beginning.  Doesn't
> appear to be a kernel bug, so let's take it off list.  You can bring it up on
> VMTN http://www.vmware.com/community/index.jspa?categoryID=1 for more on-topic
> support.  In fact, interesting test you can try - suspend / resume during the
> hang.  Does the discontinuity during calibration make it go away?

http://www.vmware.com/community/thread.jspa?threadID=60663



	-`J'
-- 
