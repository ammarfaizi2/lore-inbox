Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTLIXCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTLIXCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:02:08 -0500
Received: from mta02.alltel.net ([166.102.165.144]:60848 "EHLO
	mta02-srv.alltel.net") by vger.kernel.org with ESMTP
	id S262188AbTLIXCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:02:05 -0500
Subject: Another Kernel Oop
From: "Jonathan A. Zdziarski" <jonathan@nuclearelephant.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1070895991.2928.6.camel@tantor.nuclearelephant.com>
References: <1070825737.2978.7.camel@tantor.nuclearelephant.com>
	 <20031208004742.GB23644@kroah.com>
	 <1070851506.2942.0.camel@tantor.nuclearelephant.com>
	 <20031208074509.GB24585@kroah.com>
	 <1070895991.2928.6.camel@tantor.nuclearelephant.com>
Content-Type: text/plain
Message-Id: <1071011104.3146.9.camel@tantor.nuclearelephant.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 18:05:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another kernel oops that occurs when you try to shut down apmd using the
redhat script...I'm wondering if this may be why my thinkpad refuses to
power down or suspend in 2.6 (I've tried real-mode power off and
APM-BIOS Interrupts).

Oops: 0000[#1]
CPU: 0
EIP: 0060:[<229871db>] Tained: GF
EFLAGS: 00010246
EIP is at 0x229871db
eax: 00000000 ebx: 00000000 ecx: 00000000 edx: 02318000
esi: 00000010 edi: 00000000 ebp: 00000000 esp: 02319f9c
ds: 0076 es: 007b ss: 0068

Process Swapper (pid: 0, threadinfo=02318000 task=022aaa60)

Stack 00000005 00000202 02310000 00000000 fffee0db 00000010 00000001
0008e000
      229872c4 00005305 00000000 00000000 02319fd0 00000005 229873a1
02318000
      0001080e 00099800 02107000 0210a3e5 0231a5c6 022aaa60 00000000
0233e0a0

Call Trace

[<02107000>] rest_init+0x0/0x4d
[<0210a3e5>] cpu_idle+0x2c/0x35
[<0231a5cb>] start_kernel+0x15e/0x187

Code: Bad EIP Value
<0>Kernel Panic: Attempted to kill the idle task

In idle task - not syncing


