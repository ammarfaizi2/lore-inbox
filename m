Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTKYGkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 01:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTKYGkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 01:40:20 -0500
Received: from iisc.ernet.in ([144.16.64.3]:28352 "EHLO iisc.ernet.in")
	by vger.kernel.org with ESMTP id S262050AbTKYGkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 01:40:14 -0500
From: anand@eis.iisc.ernet.in (SVR Anand)
Message-Id: <200311250639.MAA21483@eis.iisc.ernet.in>
Subject: Re: 2.6.0-test9 : bridge freezes
To: shemminger@osdl.org (Stephen Hemminger)
Date: Tue, 25 Nov 2003 12:09:57 +0530 (GMT+05:30)
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, bridge@osdl.org
In-Reply-To: <20031124110939.1cb3f87c.shemminger@osdl.org> from "Stephen Hemminger" at Nov 24, 2003 11:09:39 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To begin with, thanks a lot for the concern you all have shown to address my 
problem.

This morning I have put in test9-bk25 image to see if the problem disappears. 
The result should be out in the next few hours. I hope it is OK if I send you 
the slabinfo in case the problem persists. 

I plan to test in stages.

i) Just bridging, no iptables
ii) With iptables.

I have very limited set of iptables rules. In fact it is as simple as blocking
icmp. There are no errors reported by ethernet devices.

Anand

PS : The latest test10 stops at the booting stage while initialising my aic7xxx
     scsi. So, I had to use bk25. 
> 
> Linus is right, this is probably a memory leak issue.  There are several areas
> that could be the problem:
> 	- core networking 
> 	- iptables
> 		- iptables filter
> 	- ethernet bridging
> 	- ethernet driver (rtl8169)
> 
> To find/fix the problem, we need to narrow down the scope.  
> Things that would help are, what are the iptables rules you are using?
> Are there any errors showing up on the ethernet devices?
> Also what does the bridge forwarding table look like? are there lots of entries, are
> you running spanning tree?
> 
> 
> 

