Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUKOUtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUKOUtr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbUKOUsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:48:17 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:47502 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261707AbUKOUrz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:47:55 -0500
Message-ID: <419916CA.8060805@tmr.com>
Date: Mon, 15 Nov 2004 15:51:22 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Steven E. Woolard" <tuxq@tuxq.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem: 2.4.26/27 & 2.6.9 Audio CD Burning
References: <41960FC8.3040004@tuxq.com>
In-Reply-To: <41960FC8.3040004@tuxq.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven E. Woolard wrote:
> I've reproduced this problem on my system with 2.4.26, 2.4.27, and 
> 2.6.9. When trying to burn an audio CD with cdrecord, the system load 
> average will skyrocket (relitively speaking) up to 4 or 5 sometimes 
> reaching 10 or higher. This does not happen with data CD's or at all 
> with 2.6.7 kernel. I used scsi emulation (of course) on 2.4.26 and 
> 2.4.27--not 2.6.9.
> 
> Side Notes:
>     DMA is enabled, I have tried downgrading cdrtools, and if 
> I             remember correctly it has the same problem in 2.6.8(.1).
> 
> Hardware:
>     AMD Athlon XP 2400+
>     1024MB RAM
>     VIA VT82C686 Southbridge (IDE Controller)
>     LITE-ON LTR48246S CDRW Drive

My understanding based on experience is that with a 2.4 kernel you will 
get a high load average burning audio, and the quickest fix is to use 
speed= to slow the burn.

With 2.6 you should get DMA using the ATAPI:/dev/hdX interface, and in 
fact I do see only a few percent CPU burning at 40x (max) and a lowly 
2.0GHz Celeron.

If none of this helps, do run "vmstat 1" to a file while running, and 
post your command line used to start the burn. You might try "ATA:" as 
well for comparison. I don't know if "-dummy" will allow you to test 
without actually burning or not.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
