Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbULMLwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbULMLwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbULMLwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:52:18 -0500
Received: from smtp1.cict.fr ([195.220.59.41]:29158 "EHLO smtp1.cict.fr")
	by vger.kernel.org with ESMTP id S262234AbULMLwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:52:12 -0500
Message-Id: <200412131152.iBDBq6501500@germania.ups-tlse.fr>
Date: Mon, 13 Dec 2004 12:52:03 +0100 (CET)
From: FRAHM Klaus <frahm@irsamc.ups-tlse.fr>
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: Re: [Fwd: 2.6.10-rc3: tulip-driver: tulip_stop_rxtx() failed]
To: grundler@parisc-linux.org
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041213035936.GB26501@colo.lackof.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Definitely not compatible.
> 
> And as noted in the previous email, I don't advise ifdown the NIC
> unless you can verify it will not corrupt the memory that was
> previously used for RX descriptors and RX buffers.
> 
> OTOH, 100BT cards are *so* cheap, it should be possible to replace
> if it's not built-in on the motherboard.
> 
> Sorry for the bad news and thanks for doing the extra tests.
> 
> But still, I'm hopeing for two code changes as a result:
> 1) include CSR5 and CSR6 in the printk output
> 2) the date of the tulip driver revision needs to be updated (or dropped).
> 
> thanks,
> grant

Hi Grant,

thanks for the analysis. It's good to know not to deactivate the NIC. I
never knowingly encoutered any real problem, but maybe there may been
other of problems which I did not attribute to the NIC. Normally I do
not deactivated the interface, but up to a few weeks ago the DHCP daemon
could do this in order to change the IP number. Now this is over and I
have since then a fixed IP number (because I am directly connected to
the DSLAM of my ISP, this is called "degroupage" in France as opposed to
IP/ADSL where one is only indirectly connected with Franc-Telecom). 
I am actually using a "Freebox" as a modem which has recently, `let's
say', arisen some interest in the linux-kernel mailing list because it
runs Linux inside: 

http://marc.theaimsgroup.com/?l=linux-kernel&m=109936781417837&w=2

For the NIC I have mentioned in my first message that I have two NICs,
the other being a 3Com card which is mostly likely better. I will simply 
switch the roles between my first and the second interface by exchanging
the aliases for eth0/1 in modprobes.conf. Then I use the Sitecom card
with the tulip driver only for the internal connection which is never
shut down and not so often used.


Greetings, Klaus.


