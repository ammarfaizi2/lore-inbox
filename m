Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132414AbRDCSqi>; Tue, 3 Apr 2001 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbRDCSq2>; Tue, 3 Apr 2001 14:46:28 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:18184 "HELO
	mail5.speakeasy.net") by vger.kernel.org with SMTP
	id <S132414AbRDCSqP>; Tue, 3 Apr 2001 14:46:15 -0400
Message-ID: <3ACA0C83.1E5A6020@megapathdsl.net>
Date: Tue, 03 Apr 2001 10:46:43 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac28 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: David Brownell <david-b@pacbell.net>
Subject: Contacts within AMD?  AMD-756 USB host-controller blacklisted due to 
 erratum #4.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.4.2-ac28, I get the following error:

usb-ohci.c: 00:07.4 (Advanced Micro Devices [AMD] AMD-756 [Viper] USB):
blacklisted, erratum #4

David Brownell recently added this check to the usb-ohci driver
since noone has gotten information from AMD for the workaround,
which is rumored to exist, for this bug.

Do any of you have contacts within AMD who might be able to
get an explanation of the workaround to David Brownell?

The bug is that the NDP value sent by the AMD-756 is sometimes
bogus.  The following examples, collected before the chip
was blacklisted, show the failure.  As you can see, the bogus 
value given varies.  Rereading NDP seems to give a valid value.  
I am not really clear why we don't simply read the value twice 
whenever the host-controller is detected to be an AMD-756.

Mar  4 17:20:52 aerie kernel: usb-ohci.c: bogus NDP=128 for OHCI
usb-00:07.4
Mar  4 17:20:52 aerie kernel: usb-ohci.c: rereads as NDP=4

Mar  4 17:50:29 aerie kernel: usb-ohci.c: bogus NDP=245 for OHCI
usb-00:07.4
Mar  4 17:50:29 aerie kernel: usb-ohci.c: rereads as NDP=4

Mar  6 21:11:07 aerie kernel: usb-ohci.c: bogus NDP=210 for OHCI
usb-00:07.4
Mar  6 21:11:07 aerie kernel: usb-ohci.c: rereads as NDP=4

Thanks,
	Miles
