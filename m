Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVGSQBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVGSQBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVGSQBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 12:01:47 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:398 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261498AbVGSQBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 12:01:42 -0400
Mime-Version: 1.0 (Apple Message framework v622)
Content-Transfer-Encoding: 7bit
Message-Id: <e93921519c29efda5b7a304d019dcc94@helenandmark.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Mark Burton <mark@helenandmark.org>
Subject: tx queue start entry x dirty entry y (was 8139too PCI IRQ issues)
Date: Tue, 19 Jul 2005 18:00:49 +0200
X-Mailer: Apple Mail (2.622)
X-Spam-Virus: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm getting similar results to Nick Warne, in that when my ethernet is 
stressed at all (for instance by NFS), I end up with
nfs: server..... not responding, still trying
nfs: server .... OK

With a realtec card, I get errors in /var/spool/messages along the 
lines of:
Jul  3 14:31:13 localhost kernel: eth1: Transmit timeout, status 0c 
0005 c07f media 00.
Jul  3 14:31:13 localhost kernel: eth1: Tx queue start entry 1160  
dirty entry 1156.
Jul  3 14:31:13 localhost kernel: eth1:  Tx descriptor 0 is 0008a03c. 
(queue head)

I have no TPM (as far as I can find)

Hence I dont think this is the same problem, but it's manifestation is 
identical.

I was using a realtec card, using the 8139too driver, hence I first 
suspected that. As a test, I have an even older 3com509B, using that 
gives exactly the same results (though it doens't seem to be kind 
enough to output anything to /var/log/debug, so all you get are the 
"server not responding" messages under heavy NFS load.
lsmod however, shows both modules loaded....

I'm running debian, and recently got a recent kernel image
/proc/version gives:
Linux version 2.6.11-1-386 (dannf@firetheft) (gcc version 3.3.6 (Debian 
1:3.3.6-6)) #1 Mon Jun 20 20:53:17 MDT 2005

Im not a kernel expert at all, any help sorting this problem would be 
appreciated, but Its only worth fixing if it's a general problem -- if' 
I'm on my own, I'll fix it with a band-aid :-)

Cheers

Mark.


