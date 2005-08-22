Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVHVW0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVHVW0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVHVW0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:26:00 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751408AbVHVWZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:45 -0400
Message-ID: <430987B1.80207@ti-wmc.nl>
Date: Mon, 22 Aug 2005 10:07:13 +0200
From: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Rainer Koenig <Rainer.Koenig.Usenet@gmx.de>
Subject: Re: SATA status report updated
References: <4DbcF-8ux-3@gated-at.bofh.it> <4DbcG-8ux-5@gated-at.bofh.it>	<4DbcF-8ux-1@gated-at.bofh.it> <4DjWG-4ea-19@gated-at.bofh.it>	<4Do9X-1IZ-5@gated-at.bofh.it> <4Dp62-304-15@gated-at.bofh.it> <87r7co4o3m.fsf@Rainer.Koenig.Abg.dialin.t-online.de>
In-Reply-To: <87r7co4o3m.fsf@Rainer.Koenig.Abg.dialin.t-online.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rainer

Rainer Koenig wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
>>8) The DMA pad code is very buggy.  It uses the dma_map_single() to
>>map a buffer, but never synchronizes nor flushes the buffer.  This can
>>and will lead to data corruption, particularly on x86-64 platform.
> 
> 
> That's very bad since the target platform for that chipset is able
> to support AMD64. :-(

that was my conclusion as well!

> From your comments I've learned that my patch (just the device ID) is
> too tiny and the SiS provided patch is doing too much things that it
> shouldn't do. How can we find a solution for that? 
> 
> Would it make sense that I try to find the "goods" in the SiS patch and
> merge them somehow in the actual kernel? But: What kernel shall I take
> to do that work? The latest development kernel, the kernel of my 
> distribution (whatever this will be, sooner or later it has to work
> with all distributions) or just a kernel that is "close" to the patch
> from SiS, e.g. 2.6.10? 
> 
> As I mentioned before, getting hardware to try out patches wouldn't be
> that big deal since I'm located in a PC factory and I can get test 
> machines if needed. What would be good tests to e.g. detect the problems
> that you mentioned above? Are there hardware specific tests for SATA
> hard disks around? I would be very interested in that since testing 
> also under Linux will become daily work for me and my colleauges from
> the system test department.

I'll be happy to test patches that come up. I'm currently running 
2.6.13-rc6-mm1, because it also has the sis190 ethernet driver in it, 
which actually does work :-)

Unfortunately I'm not able to check the logic of the driver, because 
although I can read C, I'm totally unfamiliar with the disk controler 
logic in the kernel...

Cheers

Simon

