Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283439AbRLDUnl>; Tue, 4 Dec 2001 15:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283376AbRLDUmO>; Tue, 4 Dec 2001 15:42:14 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:8832 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283424AbRLDUl7>; Tue, 4 Dec 2001 15:41:59 -0500
Message-ID: <3C0D350F.9010408@optonline.net>
Date: Tue, 04 Dec 2001 15:41:51 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> There is a new version of the driver (0.07) on my web site.  It has 
> this issue and one other issue fixed (hopefully).  The other issue is 
> when using artsd with the 0.06 driver, I had a report that artsd would 
> end up waiting on select forever and never getting woken up.  The 0.07 
> driver changes wait queue and lvi handling in a few strategic places, 
> so it should work.  However, it's untested.  Reports welcome. 

With 0.07, the kernel goes into an endless sleep as soon as artsd calls 
select(). I don't think the looping changes to i810_poll are correct... 
or even necessary? though the userfragsize change is probably appropriate.

