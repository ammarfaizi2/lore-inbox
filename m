Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUKOQEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUKOQEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 11:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUKOQEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 11:04:41 -0500
Received: from smtp.wp.pl ([212.77.101.160]:57523 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S261631AbUKOQEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 11:04:38 -0500
Date: Mon, 15 Nov 2004 17:04:52 +0100
From: Marek Szuba <scriptkiddie@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: mdacon problem
Message-Id: <20041115170452.02a93dfb.scriptkiddie@wp.pl>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO(Body=1 Fuz1=1 Fuz2=1) AS2=YES(1.000000) AS3=NO AS4=NO                         
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Recently I have attempted to, in addition to my Matrox framebuffer
console, enable a second head text console using mdacon driver;
unfortunately I have been able neither to get it working nor to find any
information on this in the docs or on the net.

First of all, some technical data - the kernel I use at present is 2.6.7
(following problems with 2.6.9 which I shall describe in a separate
post) and the second-head graphics card is an old PCI SVGA (which I
believe might be the reason why it doesn't work; then again, AFAIK it is
compatible with the MDA mode).

What happened:
1. The second card got installed in a free PCI slot and the system got
booted. The primary graphics card works as usual, the monitor connected
to the secondary one remains in power-saving mode.

2. Having compiled the appropriate kernel module and loaded it with
"modprobe mdacon mda_first_vc=13 mda_last_vc=24", the following got sent
to syslog:
Nov 14 00:24:23 host kernel: mdacon: MDA with 8K of memory detected.    
                          
Nov 14 00:24:23 host kernel: Console: switching consoles 13-24 to MDA-2 
                          

3. Nothing else happened: the primary display works as usual and the
secondary monitor remains in off mode.

I have also tried loading the module with no options, obtaining
"Console: switching consoles 1-16 to MDA-2 80x25" but rendering the text
console unusable (probably due to fbcon).

Could you shed any light on the issue? If you need any more information,
please don't hesitate to ask.

Regards,
-- 
MS
