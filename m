Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271986AbRIDQYD>; Tue, 4 Sep 2001 12:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271989AbRIDQXx>; Tue, 4 Sep 2001 12:23:53 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:59556
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S271986AbRIDQXq>; Tue, 4 Sep 2001 12:23:46 -0400
Message-ID: <3B950034.17909E5D@nortelnetworks.com>
Date: Tue, 04 Sep 2001 12:24:20 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fred <fred@arkansaswebs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
In-Reply-To: <E15eHup-0003ir-00@the-village.bc.nu> <01090410264000.14864@bits.linuxball>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fred wrote:
> 
> I'm  curious, Alan, Why? I'm a hardware developer, and I would have assumed
> that linux would have been ideal for real time / embedded projects? (routers
> / controllers / etc.) Is there, for instance, a reason to suspect that linux
> would not be able to respond to interrupts at say 8Khz?
> of course I know nothing of rtlinux so I'll read.

I'm involved in a project where we are using linux in an embedded application. 
We've got a gig of ram, no hard drives, no video, and the only I/O is serial,
ethernet and fiberchannel.

We have a realtime process that tries to run every 50ms.  We're seeing actual
worst-case scheduling latencies upwards of 300-400ms.

So while interrupts can be handled pretty quickly, you'll want to make sure that
your buffers are big enough that your userspace app only needs to run every half
second or so.

You may be better off with rtlinux if you need better response. (Or if you're on
x86 hardware you could look at the low-latency patches.)


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
