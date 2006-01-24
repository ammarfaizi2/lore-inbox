Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWAXRyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWAXRyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWAXRyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:54:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9950 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932480AbWAXRyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:54:52 -0500
Date: Tue, 24 Jan 2006 09:54:48 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller
 11ab:4362 (rev 19)
Message-ID: <20060124095448.7a77346c@dxpl.pdx.osdl.net>
In-Reply-To: <43D5F6DD.70702@t-online.de>
References: <43D1C99E.2000506@t-online.de>
	<20060123101538.14d21bf4@dxpl.pdx.osdl.net>
	<43D52C69.5090707@t-online.de>
	<20060123112751.2e3f1b15@dxpl.pdx.osdl.net>
	<43D5F6DD.70702@t-online.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2006 10:43:57 +0100
Knut Petersen <Knut_Petersen@t-online.de> wrote:

> Stephen Hemminger schrieb:
> 
> >Could you try turning off rx checksumming (with ethtool).
> >	ethtool -K eth0 rx off
> >
> >There probably still are (generic) bugs in the netfilter code for CHECKSUM_HW
> >socket buffers.
> >
> >  
> >
> "ethtool -K eth0 rx off" does cure my problem with sky2.
> 
> Anybody is invited to send patches as the problem is 100% reproducible here.
>

Does it always show up on icmp only?

What are the iptables rules (iptables -L)

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
