Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUDLSeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUDLSeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 14:34:08 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:13546 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S263004AbUDLSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 14:34:06 -0400
From: Christian =?iso-8859-1?q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>
To: linux-kernel@vger.kernel.org
Subject: IO-APIC on nforce2
Date: Mon, 12 Apr 2004 20:39:18 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404122039.18003.christian.kroener@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a problem using LOCAL APIC and IO-APIC on my uniprocessor nforce2 board. 
With recent kernels (latest -mm and 2.6.5-linus) the timer irq gets set to 
XT-PIC, which results in having a constant hi-load of 15% (after booting) to 
about 25% (after having the system run about 12 h). Earlier versions of -mm 
set the timer-irq to IO-APIC-level (or edge, i dont remember it well) and i 
never had any constant hi-load with these versions. Since mainline kernel 
versions never ever set the timer irq to IO-APIC-{level,edge} i used to patch 
them with the ross' nforce-patches, so that the timer-irq gets to be 
IO-APCI-edge, which worked even though the patch applied with offset. Anyways 
with the latest mm-kernels these patches dont work anymore. I could apply 
them with offset but it seems the code isn't used or something else is wrong 
since the timer-irq stays XT-PIC, which results in the problems above. Could 
anyone point out, how to resolve this problem or tell me what I could do, to 
get my timer-irq right? I'm sure willing to test patches...
Thanks in advance, christian.
