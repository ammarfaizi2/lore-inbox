Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262641AbTCPKUB>; Sun, 16 Mar 2003 05:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262643AbTCPKUB>; Sun, 16 Mar 2003 05:20:01 -0500
Received: from [203.197.168.150] ([203.197.168.150]:33542 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id <S262641AbTCPKUA>; Sun, 16 Mar 2003 05:20:00 -0500
Message-ID: <3E7451DC.3050902@tataelxsi.co.in>
Date: Sun, 16 Mar 2003 15:58:44 +0530
From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
Organization: Tata Elxsi
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ADS8260 Hang
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[ If this is the wrong mailing list please point me to the right one. 
Thank you]

I having been trying to bring up the ADS8260 board and incidentally ran 
into some problems.

I initially tried using Linux 2.4.1 kernel and it worked fine and the 
board was up.
I upgraded to 2.4.17 and I found out that the system started hanging 
during boot up.

I compiled 2.4.17 for ppc boot. (I already have ppc boot on my ADS board 
and I test my development by tftp boot'ing the kernel image.

I tried tracking down where the hang could be and ended up at the RFI 
instruction where its waiting to complete the MMU initialization. The 
system executes SYNC instruction and then hangs. (arch/ppc/kernel/head.S)

I tried comparing the file head.S between 2.4.1 and 2.4.17. I found out 
some patches done inside the 2.4.1 had been made generic. There were 
patches for the BAT initialization and RAM mapping on the MPC8260.

Is there an update on the files?
Should the patches be done for 2.4.17 as well ?

Any suggestions or pointers could be very helpful.

[Running on x86 with Red Hat 8.0 and cross compiling for PPC.]

Thank you.
Regards,
Sriram Narasimhan

