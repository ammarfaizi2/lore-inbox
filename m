Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbTHVADr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbTHVADr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:03:47 -0400
Received: from ns1.riptidesoftware.com ([65.169.10.8]:14274 "EHLO
	ns1.riptidesoftware.com") by vger.kernel.org with ESMTP
	id S262938AbTHVADq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:03:46 -0400
Message-ID: <3F455DDB.2080506@riptidesoftware.com>
Date: Thu, 21 Aug 2003 20:03:39 -0400
From: Christopher Curtis <chris.curtis@riptidesoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: daniel.ritz@gmx.ch
Subject: 2.4.22-rc2 PCMCIA problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been using kernel 2.4.22-pre6 with the smbfs LFS patch and the 
airo-lock-tx-fix.patch from Daniel Ritz <daniel.ritz@gmx.ch> with much 
success relative to 2.4.21.  Since I needed to make a minor change to my 
configuration, and because I got another "BAP setup error" and effective 
crash (it scrolled a stack dump continuously and kept scrolling slower 
until it got so confused it just locked up) I decided to try 2.4.22-rc2 
which seems to have incorporated [other?] airo patches.

However, with this new kernel, I can no longer 'modprobe airo_cs' 
successfully, even though I've done a proper(?) 'depmod -a'.  I can 
'modprobe i82365' successfully followed by a successful 'modprobe ds', 
but a 'cardctl ident' gives a series of "unable to map address space" 
type errors, that go something like this:

Aug 21 23:40:22 j23 kernel: Linux Kernel Card Services 3.1.22
Aug 21 23:40:22 j23 kernel:   options:  [pci] [cardbus] [pm]
Aug 21 23:40:22 j23 kernel: ds: no socket drivers loaded!
Aug 21 23:40:22 j23 kernel: unloading Kernel Card Services
Aug 21 23:40:41 j23 kernel: Linux Kernel Card Services 3.1.22
Aug 21 23:40:41 j23 kernel:   options:  [pci] [cardbus] [pm]
Aug 21 23:40:41 j23 kernel: Intel PCIC probe:
Aug 21 23:40:41 j23 kernel:   Vadem VG-468 ISA-to-PCMCIA at port 0x3e0 
ofs 0x00, 2 sockets
Aug 21 23:40:41 j23 kernel:     host opts [0]: none
Aug 21 23:40:41 j23 kernel:     host opts [1]: none
Aug 21 23:40:41 j23 kernel:     ISA irqs (scanned) = 7,10,14 polling 
interval = 1000 ms
Aug 21 23:41:01 j23 kernel: cs: unable to map card memory!
Aug 21 23:41:01 j23 last message repeated 5 times

Thought someone might like to know ... I'm going back to -pre6 ...

regards,
Chris

