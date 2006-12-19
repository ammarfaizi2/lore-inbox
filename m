Return-Path: <linux-kernel-owner+w=401wt.eu-S932106AbWLSOcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWLSOcS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 09:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWLSOcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 09:32:18 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:47822 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbWLSOcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 09:32:17 -0500
Date: Tue, 19 Dec 2006 08:32:04 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6.20-rc1
In-reply-to: <20061219124130.GN5010@kernel.dk>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <4587F7E4.8000609@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <200612142144.26023.s0348365@sms.ed.ac.uk> <4581C73F.6060707@garzik.org>
 <200612142233.10584.s0348365@sms.ed.ac.uk> <20061219124130.GN5010@kernel.dk>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Just noticed that most of the mails I wrote on this thread were
> apparently without linux-kernel cc'ed (dunno who removed the cc). So
> I'll write a small summary - the problem is that hddtemp includes some
> fragile code to check the sense info, and this commit:
> 
> http://git.kernel.dk/?p=linux-2.6-block.git;a=commit;h=f38621b3109068adc8430bc2d170ccea59df4261
> 
> broke it. hddtemp expects 14, but it now sees 12. IMHO hddtemp is buggy
> and should be fixed, the best option is simply to kill the sense checks
> as I think they have little (if any) value. Patch below for that.
> 
> So the problem was never the SG_IO changes, the fact that somebody
> noticed the same thing in bugzilla for a 2.6.19-rc6-mm kernel backs that
> up.

 From what I've seen it appears that smartctl has the same problem, it 
was also reporting the device didn't support SMART..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


