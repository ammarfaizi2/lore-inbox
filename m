Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283445AbRLDURn>; Tue, 4 Dec 2001 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283411AbRLDUQF>; Tue, 4 Dec 2001 15:16:05 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:27008 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S281664AbRLDUOr>; Tue, 4 Dec 2001 15:14:47 -0500
Message-ID: <3C0D2EB3.9090402@optonline.net>
Date: Tue, 04 Dec 2001 15:14:43 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <3C0C765D.8040304@optonline.net> <3C0CFDDE.40805@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> I fixed the clocking issue in my source.  I need more details on the 
> artsd problem though.  Does artsd start to work and then stop, or does 
> it never get around to outputting any sound?  Also, do you have any of 
> the debugging output turned on (it *drastically* changes the timings 
> in the driver and can make things that normally work fail and vice versa)?

It works for a while then stops. select() works properly for a while, 
and then starts returning timeouts.

I've tried this with DEBUG both on and off, and also with 
DEBUG_INTERRUPTS on/off... no difference.

I don't see anything too interesting in DEBUG+DEBUG2 output. Select() 
stops working after the buffer fills up (after 4 seconds with artsd set 
to 256byte fragments*32) and doesn't start working again after the 
buffer begins to drain.

