Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbULQGBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbULQGBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 01:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbULQGBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 01:01:16 -0500
Received: from [205.158.62.125] ([205.158.62.125]:34178 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262011AbULQGBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 01:01:13 -0500
Subject: Re: [SoftwareSuspend-devel] 2.6 Suspend PM issues
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Michael Frank <mhf@berlios.de>
Cc: SoftwareSuspend Development 
	<softwaresuspend-devel@lists.berlios.de>,
       Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412171315.50463.mhf@berlios.de>
References: <200412171315.50463.mhf@berlios.de>
Content-Type: text/plain
Message-Id: <1103263067.19280.4.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Dec 2004 16:57:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael.

On Fri, 2004-12-17 at 16:15, Michael Frank wrote:
> Hi Nigel,
> 
> By what was discussed wrt ALSA issue I gather that you still resume _all_ 
> drivers after doing the atomic copy?
> 
> As explained earlier this year, if this is the case, it is firstly 
> unacceptable as it will result in loss of data in many applications and 
> secondly very clumsy.
> 
> Example With 2.4 OK, with 2.6 It would fail:
> A datalogger connected to a seral port of a notebook in the field. Data 
> transfer in progress which can be put on hold bo lowering RTS (HW handshake) 
> but _cannot_ be restarted. Battery low, must suspend to change battery, upon 
> resume transfer can continue.
> 
> Will this be taken care of?

Until 2.1.5.8, I had put in support ('device trees') for handling the
devices we're using in writing the image separately. Unused devices were
suspending prior to beginning to write the image and not resumed before
powerdown. At resume time, they were suspended and not resumed until the
whole image had been re-read. In short, it did what you're asking.

>From what I understand, though, work on the driver model and individual
drivers should be making this unnecessary. If that's not true, I'll
happily put the device tree code back in. For now, though, I've been
seeking to implement changes that will help with getting the code
merged, and this was one of them.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

