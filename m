Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVIGOp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVIGOp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVIGOp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:45:59 -0400
Received: from mail4.zigzag.pl ([217.11.136.106]:39599 "HELO mail4.zigzag.pl")
	by vger.kernel.org with SMTP id S1751155AbVIGOp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:45:58 -0400
Message-ID: <431EFD0E.9030409@zabrze.zigzag.pl>
Date: Wed, 07 Sep 2005 19:15:34 +0430
From: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050827)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Valdis.Kletnieks@vt.edu, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Patch for link detection for R8169
References: <431DA887.2010008@zabrze.zigzag.pl> <20050906194602.GA20862@electric-eye.fr.zoreil.com> <200509062002.j86K28R8019604@turing-police.cc.vt.edu> <20050906204221.GB20862@electric-eye.fr.zoreil.com>
In-Reply-To: <20050906204221.GB20862@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Qmail 1.6.2 on
 mail4.zigzag.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu napisał(a):

>Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> :
>[...]
>
>Ok, thanks for the hint.
>
>Currently one can do 'ifconfig ethX up', check the link status, then try
>to DHCP or whatever. Apparently a few drivers do not support tne detection
>of link as presented above. So is it anything like a vendor requirement/a
>standard (or should it be the new right way (TM)) or does the userspace
>needs fixing wrt its expectation ?
>  
>
The main problem with this driver is, that if I do like this, then every 
10 seconds I receive new message from the network card in kernel log.
There is following message:

Sep  4 16:31:43 laptop_mirka eth0: PHY reset until link up
Sep  4 16:31:53 laptop_mirka eth0: PHY reset until link up

Do you think, that this is correct way t do the things? I
In my opinion, the solution, that link status can be checked (if 
hardware allow this) when interface is down is more usefull.


