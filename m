Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbUKKPdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbUKKPdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbUKKPct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:32:49 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37075 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262249AbUKKP2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:28:35 -0500
Subject: Re: [AX25]: Fix cb lookup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ralf@linux-mips.org, davem@davemloft.net, torvalds@osdl.org
In-Reply-To: <200411110108.iAB18g00028445@hera.kernel.org>
References: <200411110108.iAB18g00028445@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100183113.22255.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 11 Nov 2004 14:25:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-10 at 05:54, Linux Kernel Mailing List wrote:
> ChangeSet 1.2026.76.14, 2004/11/09 21:54:43-08:00, ralf@linux-mips.org
> 
> 	[AX25]: Fix cb lookup
> 	
> 	Ax AX.25 connection is identified only by it's source and destination,
> 	not by the device it's routed through, so fix the connection block
> 	lookup to ignore the device of a connection.  This fixes dying connections
> 	in case of an AX.25 routing flap.

At least the way some networks are run this is incorrect. You've just
killed AX.25 support for networks that do assume the same callsign on a
different
frequency is a different connection. This should at least have a sysctl
to switch the behaviour. 

The whole notion of an AX.25 routing flap is mildly amusing given that
AX.25 isnt routed but is a link layer point to point protocol with a
broadcast datagram hack attached. I know people do it just like they
"route" netbeui but the default behaviour ought to reflect the AX.25
standard document and do the link layer checks.

Alan


