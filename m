Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUIJMGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUIJMGW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUIJMGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:06:22 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:54288 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267367AbUIJMEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:04:51 -0400
Message-ID: <328eb89b04091005041dabdef2@mail.gmail.com>
Date: Fri, 10 Sep 2004 14:04:51 +0200
From: Wojtek <wojtekr@gmail.com>
Reply-To: Wojtek <wojtekr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: performace problem, D state
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I seem to suffer from the same problem as described by Petr
in this post: http://lkml.org/lkml/2004/8/10/126

Performance of my machine gets really ugly
when doing I/O. Untaring stuff or copying files
brings the machine down, responsiveness
is really poor and load average sometimes goes 
as high as ten (CPU usage is very low then,
but I got usually near 100% value in wa column in top).

This is K8T Neo MSI motherboard with VIA chipset, Athlon64 CPU
(one, it's not SMP mobo). I'm using only IDE controller (SATA disabled). 

lspci shows this IDE hardware:

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800 South] (prog-if 00 [Normal decode])
0000:00:0f.0 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])

Already tried playing with apic/acpi different kernel boot-parameters, they
don't help much. I've also been told that changing elevator to
'deadline' doesn't
affect this behaviour.

I have seen also other people (IRC/linux forums) having this issue
with MSI motherboards
with VIA IDE chipset and amd64 architecture.

I'd appreciate any hints which could help us to locate
the cause of this behaviour.

-- 
wr.
