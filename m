Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbQJ3Wa4>; Mon, 30 Oct 2000 17:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129690AbQJ3Wau>; Mon, 30 Oct 2000 17:30:50 -0500
Received: from va-ext.webmethods.com ([208.234.160.252]:49529 "EHLO
	localhost.neuron.com") by vger.kernel.org with ESMTP
	id <S129170AbQJ3Wae>; Mon, 30 Oct 2000 17:30:34 -0500
Date: Tue, 31 Oct 2000 05:32:32 -0500 (EST)
From: stewart@neuron.com
To: linux-kernel@vger.kernel.org
Subject: trouble with apm on dell latitude cs in 2.2.1[67]
Message-ID: <Pine.LNX.4.10.10010281227460.1211-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I've recently upgraded a latitude cs running redhat 6.2 on 2.2.14 with
 card services v3.1.14 to 2.2.17 with card services v3.1.21. Immediately
 I noticed that suspend/resume was broken. Well, suspend was working fine
 but when I raised the lid, the system would come back like normal, then
 the HD drive light would go solid and a few seconds later the system
 would lock hard. No oops or any other indicators. I tried tailing the
 /var/log/messages file (starting before the suspend), but this revealed
 nothing at first. After about 5 tries I managed to elicit one error
 in the log:

 "hda: timeout waiting for DMA"

 but this message did not show up consistently. I tried backing down to
 2.2.16 in case it was a recent bug and then also tried backing up to a
 previous version of card services, but none of this helps. Unless I go
 back to 2.2.14, this system will lock hard on a resume about 7-10 seconds
 after I raise the lid.

 Lacking any other kernel debugging skills, I compiled sysrq into the kernel
 hoping to get something more useful for the list. Although 'showkey -s'
 does generate 0x54 codes, pressing alt-sysrq-<key> yields nothing in the
 kernel I just built it into (2.2.17). 

 One another kernel note, I cannot get the 2.4.0-test9/10 kernels to boot
 on this machine. After lilo, it says:

 "Uncompressing Linux... Ok, booting the kernel."

 then the machine hangs solid. It is not recoverable via alt-ctrl-del.
 I have to hold the power button until the machine cycles. I have no data
 for earlier 2.4.0 kernels.

 What else can I do to debug this and what other info will help in
 identifying the problem?

 Thanks,

 Stewart

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
