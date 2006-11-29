Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758769AbWK2CFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758769AbWK2CFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 21:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757763AbWK2CFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 21:05:48 -0500
Received: from gate.cdi.cz ([80.95.109.117]:7149 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id S1758769AbWK2CFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 21:05:47 -0500
Message-ID: <456CEAEC.6010802@cdi.cz>
Date: Wed, 29 Nov 2006 03:05:32 +0100
From: Martin Devera <devik@cdi.cz>
User-Agent: Thunderbird 1.5.0.5 (X11/20060729)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       lkosewsk@gmail.com, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.15.4 rel.2 1/1] libata: add hotswap to sata_svw
References: <E1F9klH-0004Fg-00@devix>	 <1164756139.14595.37.camel@pmac.infradead.org> <1164758483.5350.113.camel@localhost.localdomain>
In-Reply-To: <1164758483.5350.113.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.6 (--)
X-Spam-Report: * -2.6 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Tue, 2006-11-28 at 23:22 +0000, David Woodhouse wrote:
>> On Thu, 2006-02-16 at 16:09 +0100, Martin Devera wrote:
>>> From: Martin Devera <devik@cdi.cz>
>>>
>>> Add hotswap capability to Serverworks/BroadCom SATA controlers. The
>>> controler has SIM register and it selects which bits in SATA_ERROR
>>> register fires interrupt.
>>> The solution hooks on COMWAKE (plug), PHYRDY change and 10B8B decode 
>>> error (unplug) and calls into Lukasz's hotswap framework.
>>> The code got one day testing on dual core Athlon64 H8SSL Supermicro 
>>> MoBo with HT-1000 SATA, SMP kernel and two CaviarRE SATA HDDs in
>>> hotswap bays.
>>>
>>> Signed-off-by: Martin Devera <devik@cdi.cz>
>> What became of this?
> 
> I might be to blame for not testing it... The Xserve I had on my desk
> was too noisy for most of my co-workers so I kept delaying and forgot
> about it.... 
> 
> Also the Xserve I have only has one disk, which makes hotplug testing a
> bit harder :-)

Unfortunately my box with ht1000 is already deployed. Another similar one should
arrive soon so that I'll retest it.
Just now I've VIA based mobo here - and hotswap is NOT working with it ..

Martin
