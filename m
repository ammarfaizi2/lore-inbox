Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbREUIzr>; Mon, 21 May 2001 04:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbREUIzi>; Mon, 21 May 2001 04:55:38 -0400
Received: from WARSL401PIP5.highway.telekom.at ([195.3.96.112]:13874 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id <S262409AbREUIz1>;
	Mon, 21 May 2001 04:55:27 -0400
Message-ID: <3B053183.188C47BD@violin.dyndns.org>
Date: Fri, 18 May 2001 16:28:19 +0200
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
Reply-To: dusty@strike.wu-wien.ac.at
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andy Arvai <arvai@scripps.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: APIC errors on 2.4.4
In-Reply-To: <200105180650.XAA04197@astra.scripps.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Arvai wrote:
> 
> Hi,
> 
> I'm having IO-APIC errors with 2.4.4. I spent some time searching the
> web to understand more about this problem and I'm still not sure if
> it is a hardware problem on the motherboard or a problem with the
> kernel. I will try the noapic boot option, but are there any
> patches that might fix this? Here are some of the errors I was
> getting:
> 
> May 15 22:47:43 rad kernel: APIC error on CPU0: 02(01)
> May 15 22:48:00 rad kernel: APIC error on CPU0: 01(02)

This is a hardware error. I also have a buggy motherboard (586DX) and
experience the same problems. Looke at /proc/interrupts, there you can
see how many errors are detected. The problem is that double errors are
not detected - these can lead to system crashes or block network/isdn
cards.

If there are only a few APIC errors, it is very unlikely that a double
error occurs, if there are very many, the probability is high.

It seems that there are quite a lot of motherboards that have a buggy
APIC.

There is some patch by Alan Cox in the 2.4.4-ac series that does
something about this problem but I do not know what exactly.

The only thing you can do is boot with the "noapic" option, and disable
IO-Interrupts on the second CPU (I assume you have a SMP system?). This
will reduce the amount of errors but there is also a performance
decrease.

		Regards,
		Hermann

-- 
 ,_,
(O,O)     "There is more to life than increasing its speed."
(   )     -- Gandhi
-"-"--------------------------------------------------------------
