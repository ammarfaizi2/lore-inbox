Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVFRNwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVFRNwg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 09:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVFRNwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 09:52:36 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:55959 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262114AbVFRNwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 09:52:33 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@muc.de>
Subject: [2.6.12] x86-64 IO-APIC + timer doesn't work
Date: Sat, 18 Jun 2005 14:52:52 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181452.52921.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I upgraded my nForce3 x86-64 desktop from 2.6.12-rc5 to 2.6.12 today and 
something strange started happening. Waay back in 2.6.x I had problems with 
the "noapic" default for nForce boards on x86-64, and so used the "apic" 
kernel boot parameter to force the apic on; this worked successfully for a 
long time with no timer problems.

However, as of 2.6.12 (maybe -rc6, too?) my desktop occasionally fails to boot 
with the message:

"IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter."
(arch/x86_64/kernel/io_apic.c)

However, this message is intermittent; it is sometimes possible to boot 
without getting it, and everything works fine. So I took its advice and ran 
with noapic, and everything seems fine now.

However, I just thought I'd let whoever maintains this bit of code know that 
the check isn't a "sure thing": it's not being flagged reliably. Whether this 
is my BIOS or the kernel, I don't know.

Though I clearly don't require this functionality any more, is there any 
reason I now can't use apic on this nForce3 board, where previously (on 
2.6.12-rc5 and older) I could?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
