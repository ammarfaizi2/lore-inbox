Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRH1MPF>; Tue, 28 Aug 2001 08:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270800AbRH1MO4>; Tue, 28 Aug 2001 08:14:56 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:2176 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S270795AbRH1MOx> convert rfc822-to-8bit; Tue, 28 Aug 2001 08:14:53 -0400
Importance: Normal
Subject: re: VM: Bad swap entry 0044cb00
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA77434C9.FE08E5EE-ONC1256AB6.0043214E@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Tue, 28 Aug 2001 14:15:07 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 28/08/2001 14:14:34
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I faced the same problem with the VM System on an S/390-System and Kernel
2.4.7 + S/390 patches. As there is hardware ECC-checking it is not a memory
problem.
I can reproduce the problem If I put load on the system (256 MB RAM, 512 MB
SWAP on a file, 3CPUs).

To reproduce this behaviour I run a lot of programs which consume all the
heap memory.
The C++ program uses the new function until the OOM killer is activated.

I start several of this programs with nohup prog &

This behaviour startet with 2.4.7.
With all previous Kernel versions since 2.4.0 there were a kernel BUG
messages during this test. The messages changed regularly with every new
kernel version, unfortunately we were not able to track this problem down.
Kernel 2.2 runs fine.

--
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49 7031-16-3507


