Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSGBMQT>; Tue, 2 Jul 2002 08:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSGBMQS>; Tue, 2 Jul 2002 08:16:18 -0400
Received: from mail.stellartec.com ([65.107.16.99]:45067 "EHLO
	nt_server.stellartec.com") by vger.kernel.org with ESMTP
	id <S316751AbSGBMQS>; Tue, 2 Jul 2002 08:16:18 -0400
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18-mips buffer cache problem
Date: Tue, 2 Jul 2002 05:20:44 -0700
Message-ID: <013e01c221c2$e4074950$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys. I've got 2.4.18 running on an NEC Osprey development board here
using the NEC VR4181 processor. The problem I'm having must be arch
specific, however if I knew where in the Kenrel exactly to look on the Linux
side I would stand a better chance of figuring out what's going on.

When I deal with files on either the CF card or /dev/rom, the buffer cache
fills up. That's what's supposed to happen. However, Linux never seems to
free these buffers. Once I've say, cat * > /dev/null in enough directories
the system memory will all be used up and it won't ever free it. If I
unmount the cf card, it frees up a lot of what was buffered up on the card
so it seems the arch specific memory stuff works, but why won't it free it
up otherwise? The files cached from the /dev/rom device (root fs) fills up
memory and never frees. I have another working kernel that doesn't have this
problem and I can fill up system memory with cache files and then run a
little program that takes up a ton of memory and that program will keep
running, but it page faults on this new kernel since it can't get the memory
it needs from the cache. I don't see why the OOM won't kill it first,
eitehr.

Can somebody tell me where in the Kernel it says "hey, I'm running low on
memory I should free up some of the memory in the file cache" stuff? If I
know where that happens, I can try troubleshooting the problem. I'm sure
it'll point to some specific mips problem.

Thanks!

Steve

