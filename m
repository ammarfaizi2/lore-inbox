Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUALQul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUALQul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:50:41 -0500
Received: from main.gmane.org ([80.91.224.249]:20178 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266166AbUALQuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:50:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: NillyNux <selfdest@comcast.net>
Subject: 2.6 Kernel and Ami IDE Raid Controller
Date: Mon, 12 Jan 2004 11:41:25 -0500
Message-ID: <pan.2004.01.12.16.41.25.332063@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2.90 (A Bouquet of Corpses)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been trying to get 2.6 working on my redhat box for while now.  I
have been through various versions of 2.6 but they all seem to end at the
same spot.  I just tried 2.6.1 over the weekend, and well, I guess it's
time to ask for some help. My motherboard is a Iwill DVD266-r with dual
PIII's, and on this mobo there is an AMI megaraid ide controller which
works great under kernel 2.4.20 and a few versions prior that I have tried.  

lspci reports this controller as:

00:0f.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)

and messages log shows:

Jan 10 10:53:04 pcp476248pcs kernel: CMD649: IDE controller at PCI slot 00:0f.0
Jan 10 10:53:04 pcp476248pcs kernel: CMD649: chipset revision 2
Jan 10 10:53:04 pcp476248pcs kernel: CMD649: not 100%% native mode: will probe
 irqs later

That's how it shows in 2.4.x kernels and it works great, but in 2.6.x it
kernel panics shortly after this module is loaded.  I see the module load
and it goes to detecting the drive on the controller, but in the process
of doing this, it says "IRQ to HDA1 has been lost",  it will say that
about 4 times over the course of a couple of minutes and then I get the
kernel panic.

The only difference that I have noticed with module is that during the
boot process the version of CMD649 with 2.4.20 says it's Beta3, but the
one that 2.6.x reports is Alpha, would this driver version have regressed?

Other than that, anyone got any ideas?


