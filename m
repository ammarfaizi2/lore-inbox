Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTLCMeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 07:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTLCMeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 07:34:31 -0500
Received: from th5.kapitza.ras.ru ([195.208.33.88]:23435 "EHLO
	th5.kapitza.ras.ru") by vger.kernel.org with ESMTP id S264504AbTLCMea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 07:34:30 -0500
Date: Wed, 3 Dec 2003 15:37:19 +0300 (MSK)
From: "Lev A. Melnikovsky" <leva@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: Hang after adding swap in 2.4.19-2.4.22
Message-ID: <Pine.LNX.4.58.0312031440160.10231@gu5.xncvgmn.enf.eh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I have this problem quite long already, I first noticed it when switched
from 2.4.18 to 2.4.19 and it is still here with 2.4.22 (have not tried
2.4.23 yet). The system "hangs" during the early stages of initscripts
execution. In my case these are RedHat initscripts (several versions
tried) but other people reported similar problems with Mandrake (look for
the words like "hang finding module dependencies" or "hang mounting local
filesystems"). There was a similar post to the LKML (Brad Tilley, Jun 23
2003, "OS Fails to Load"). Unfortunately the problem is not 100%
reproduceable in the sense the system "hangs" some 10%-50% (your mileage
may vary) of times. On the other side the problem was seen here at three
separate computers with quite different hardware (well, all CPUs are i386,
but they are Celeron 533, Athlon XP 2200+ and XP 1700+).

I have collected all possible stack traces, PCs, memory info etc. The
bunch is available from http://kapitza.ras.ru/~leva/ops.tar.bz2

[leva@ari ops]$ tar -tjf ops.tar.bz2
addresses.txt
oooooops.txt
ops-improved.txt
readme
.config

If you ask, yes, it does include ksymoops (ops-improved.txt) and addr2line
(addresses.txt) outputs. And the kernel is just a 2.4.22 with a patch from
http://w.ods.org/tools/kmsgdump/0.4.4/patch-2.4.23p6-kmsgdump-0.4.4.gz
just to store the dump after the hang.

I would really appreciate if someone could tell me what the problem is
and, if this is my own misconfiguration, how I should avoid it. Otherwise,
if this is a bug, some fix would be available, probably... I will be glad
to supply any additional information if needed.

If replying, please CC me, as I am not subscribed. Thanks in advance
-L.
