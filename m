Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270693AbTG0I16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 04:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270694AbTG0I15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 04:27:57 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:33367 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S270693AbTG0I1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 04:27:54 -0400
Message-ID: <3F239071.7000905@myrealbox.com>
Date: Sun, 27 Jul 2003 16:42:25 +0800
From: Romit Dasgupta <romit@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Re : Re: Debug: sleeping function called from invalid context
Content-Type: multipart/mixed;
 boundary="------------060707080100000202080303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060707080100000202080303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

/>> /
/>> Just found some debug messages like the subject above, from /
/>> the latest kernel compiled with debug options. Attached are the dmesg /
/>> output and the .config file. Not sure if anyone has seen this. /

 >Probably some initcall has more spin_lock()s than spin_unlock()s and the
 >init process's preempt count ended up permanently out of whack.

 >Please boot with "initcall_debug=1" on the boot command line and if 
you see
 >a line of the form:

 >error in initcall at 0xXXXXXXXX: returned with preemption imbalance

 >then please look up 0xXXXXXXXX in System.map and let us know.

Hello Andrew,
                         Thanks for your help. The problem does not show 
up on every boot. I really dont know, what causes it to trigger. 
Nevertheless, I booted with the options you suggested. I kept executing 
dmesg often, and this time i was lucky to get those errors back again! 
So I am attaching the output of dmesg. Unfortunately, I can't see any 
message like ".....: returned with preemption imbalance".

Regards,
-Romit


--------------060707080100000202080303
Content-Type: application/x-gzip;
 name="dmesg.out.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.out.gz"

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
--------------060707080100000202080303--

