Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130940AbRBIWnY>; Fri, 9 Feb 2001 17:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131016AbRBIWnO>; Fri, 9 Feb 2001 17:43:14 -0500
Received: from cs167115-141.austin.rr.com ([24.167.115.141]:54081 "EHLO
	fido2.homeip.net") by vger.kernel.org with ESMTP id <S130936AbRBIWnA>;
	Fri, 9 Feb 2001 17:43:00 -0500
Message-ID: <3A84726C.4B07B601@mail.utexas.edu>
Date: Fri, 09 Feb 2001 16:42:52 -0600
From: Philip Langdale <philipl@mail.utexas.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac6 i686)
X-Accept-Language: en, zh, zh-CN, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PCI clock 
 detection
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Vojtech,

I've tried out your new via driver and it
appears to have solved the problem with
the mis-detected ls-120 drive, but the ata66
drives are still being run at 33. 

More interestingly, the pci-clk calculations
seem to be returning badly off values.

My motherboard is a kt133a+686b btk7a from abit.

When I set the FSB to 133 with PCI=133/4=33 the
timing code returns 43mhz.

when I set the FSB to 100 with PCI=100/3=33 then
it returns 42mhz.

These are scarely different from the nominal values.
I didn't observe anything bad in the few minutes
I was running like this, but right now I've hacked
the driver back to a hardcoded 33.

What should I do next?

--phil
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
