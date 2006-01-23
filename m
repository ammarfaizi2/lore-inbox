Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWAWSPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWAWSPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWAWSPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:15:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751243AbWAWSPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:15:46 -0500
Date: Mon, 23 Jan 2006 10:15:38 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller
 11ab:4362 (rev 19)
Message-ID: <20060123101538.14d21bf4@dxpl.pdx.osdl.net>
In-Reply-To: <43D1C99E.2000506@t-online.de>
References: <43D1C99E.2000506@t-online.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O
> 
> It seems that the SuSE Firewall locked something ....
> 
> I started with kernel 2.6.15-git7, tried 2.6.15.1 and 2.6.16-rc1*.
> At the moment I do use a kernel 2.6.15-git7 patched with an updated sky2 
> (v.013).
> I could not find a single working sky2 configuration.
> 

Are you using the full kernel.org kernel, or are you putting sky2 driver into
the SUSE kernel? There are a number of bug fixes related to hardware checksumming
that are in the kernel.org kernel (2.6.15 or later).  There was one in ICMP.
These fixes relate to places in the code where a protocol decides to trim a
packet by removing bytes. I am not familiar with the SuSE Firewall. Is it just
standard netfilter modules or additional code?

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
