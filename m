Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbRGJSir>; Tue, 10 Jul 2001 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267074AbRGJSih>; Tue, 10 Jul 2001 14:38:37 -0400
Received: from woodyjr.wcnet.org ([63.174.200.2]:17025 "EHLO woodyjr.wcnet.org")
	by vger.kernel.org with ESMTP id <S267073AbRGJSi2>;
	Tue, 10 Jul 2001 14:38:28 -0400
Message-ID: <000b01c10970$096cd8c0$fe00000a@cslater>
From: "C. Slater" <cslater@wcnet.org>
To: <linux-kernel@vger.kernel.org>
Subject: Switching Kernels without Rebooting?
Date: Tue, 10 Jul 2001 14:42:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i was just thinking about if it would be possible to switch kernels
without haveing to restart the entire system. Sort of a "Live kernel
replacement". It sort of goes along with the hot-swap-everything ideas. I
was thinking something like
- Take all the structs related to userspace memory and processes
- Save them to a reserved area of memory
- Halt the kernel, mostly
- Wipe kernel-space memory clean to avoid confusion
- Load new kernel into memory
- Replace all saved structures
- Start kernel running agin

This seems like the easiest way to do it. The biggest problem is that there
would be somewhere about 30 seconds where all processes would be frozen.
This could cause problems with  tcp/ip connections timeing out say on a
webserver, but it would be more managable than a few minutes downtime to
restart the machine. There is one other way i can think of, something like
- Copy entire kernel memory to another reserved area of memory
- Start new kernel running as a "secondary kernel"
- Transfer control from "Primary kernel" to "Secondary Kernel"
- Load new kernel where the kernel was previously located
- Start new kernel running as a "Secondary Kernel" agin
- Transfer control between kernels
- Kill and remove temporary kernel

This system could result in nearly zero downtime, but would require more
memory, be more complicated, and would require significant modifications to
allow for a "Secondary Kernel" to be runing. Anyways, I think this could be
a nice feature of the kernel in situations where zero downtime is required.
Yes, it might be a case of "creeping featurism", but if you think so, then
tell me. If you would be interested in helping with it, send me a message,
if there is any support for it. Please CC: me any messages, it would be
quite helpful since i do not recieve the mailing list due to the excessive
volume. If you don't I will pick it up in the archives, but not as soon.
Thanks.

     Colin

