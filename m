Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282122AbRLDGIF>; Tue, 4 Dec 2001 01:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282121AbRLDGHz>; Tue, 4 Dec 2001 01:07:55 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:40320 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S282122AbRLDGHm>; Tue, 4 Dec 2001 01:07:42 -0500
Message-ID: <3C0C682A.6030707@optonline.net>
Date: Tue, 04 Dec 2001 01:07:38 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

>
> Well, your second version of the file had the merge done right (my 
> code didn't include S/PDIF support or PM support, so those parts were 
> different, but the parts that were the same as my code were done 
> correctly).  I'm attaching a patch that bumps the code from your 0.05b 
> to a unified 0.06 and I'm also placing the 0.06 i810_audio.c.gz file 
> on my web site in the same place that I put the 0.05 version.  If 
> people could please test this and report problems back, I would like 
> to get this one off my plate (aka, I don't want to hear any more about 
> artsd not working ever again so I want testers to tell me that it's 
> fixed ;-)

You'll need to do something like add "clocking = 48000;" right before 
the call to i810_set_dac_rate in i810_configure_clocking() to avoid a 
divide by zero.

