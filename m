Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271744AbTHHSdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271746AbTHHSdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:33:13 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:33680 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S271744AbTHHSdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:33:07 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-mm5: scheduler problem & apic
Date: Fri, 8 Aug 2003 19:32:56 +0100
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Holden Hao <holden@philonline.com.ph>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308081932.56347.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing occassional lockups under minor load with 2.6.0-test2-mm5. I 
believe it is related to one or more of the scheduler changes (another div by 
zero, maybe?). It's sporradic. I do not experience such instability on 2.6.0-
test2-mm2. I'm writing this on 2.6.0-test2-mm5 with the o13 patches reverted 
and it hasn't happened yet, but this boot could just be lucky. My kernel is 
not tainted.

(I just noticed o14 went live. I'll try with this in a moment.)

Andrew, I don't know if anybody's given you any feedback regarding the nForce 
2 APIC fix, but it appears to resolve the dead kernel problem, and I no 
longer have problems with IRQ fallouts when using acpi, and I've removed 
pci=noacpi from cmdline. ACPI and APIC now work together harmoniously.

However, on my EPoX 8RDA+ mainboard, I see the following in dmesg. Is this a 
bug in the APIC changes or a BIOS bug?  I'll contact EPoX about it if it's 
the latter. It does not appear to impair function, but it does get a priority 
output even when booting with 'quiet' on cmdline (if this is not that 
serious, which it does not appear to be, should this message be demoted?).

..MP-BIOS bug: 8254 timer not connected to IO-APIC

(..and hidden in dmesg)

...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
                                             ^
                                         and is therefore recoverable?

Cheers,
Alistair.
