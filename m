Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284639AbRLEUE4>; Wed, 5 Dec 2001 15:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284636AbRLEUEr>; Wed, 5 Dec 2001 15:04:47 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:42114 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S284638AbRLEUEg>; Wed, 5 Dec 2001 15:04:36 -0500
Message-ID: <3C0E7DCB.6050600@optonline.net>
Date: Wed, 05 Dec 2001 15:04:27 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> The attached patch should get me the debugging output I need to solve 
> the problem.  If you'll get me the output, then I can likely have a 
> working version in short order.

Here is a fix. It is diffed against your original 0.08 version, Doug.

It makes GETOPTR set the LVI to the hardware fragment preceding the one 
that's currently playing. In the case of Quake, that means Quake must 
call GETOPTR at least every 3/4ths of a DMA buffer. Hopefully that 
requirement should be relaxed enough. The alternate fix is to modify the 
completion handlers.

I don't see anything obvious in the databook about how to make the 
hardware loop infinitely without taking any additional input from us.

Comments, please.

