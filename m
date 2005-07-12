Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVGLJ0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVGLJ0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGLJ0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:26:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:24230 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261283AbVGLJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:26:32 -0400
X-Sasl-enc: w7dl03FYDEbKHy25QMJATzsd2wFpmFPOcuG8XJlydJI+ 1121160386
Message-ID: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: <linux-kernel@vger.kernel.org>
Cc: "Bron Gondwana" <brong@fastmail.fm>, "Jeremy Howard" <jhoward@fastmail.fm>
Subject: 2.6.12.2 dies after 24 hours
Date: Tue, 12 Jul 2005 19:26:29 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As background, we've been using a relatively old kernel (2.6.4-mm2) on some 
IBM x235 machines with 6G of RAM, umem cards, and serveraid storage. These 
machines are under continuous heavy-ish load, load avg between about 1 and 
5, with between 2500-3500 procs at all times, with several largish ReiserFS 
partitions and have been running *really* well with >250 days uptime on one 
machine.

We recently tried upgrading one of the machines to the latest kernel 
(2.6.12.2) and it's died after about 24 hours. It seemed to end up in some 
weird state where we could ssh into it, and some commands worked (eg uptime) 
but process list related commands (ps) would just freeze up into an 
unkillable state and we'd have to close the seesion and ssh in again.

I did manage to get a full sysrq-t dump. I've placed it, a kernel config 
dump, and a dmesg boot dump here:

http://robm.fastmail.fm/kernel/t7/

Hope this provides some useful data to track down the problem.

Rob

PS. Yes, I know this is a non-PAE kernel on a 6G machine so 2G was unused. 
This was a mistake in this case, but it still doesn't explain the crash...

