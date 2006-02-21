Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWBUXit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWBUXit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWBUXit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:38:49 -0500
Received: from mms2.broadcom.com ([216.31.210.18]:4869 "EHLO mms2.broadcom.com")
	by vger.kernel.org with ESMTP id S1751221AbWBUXis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:38:48 -0500
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Subject: Re: [PATCH] tg3: netif_carrier_off runs too early; could still
 be queued when init fails
From: "Michael Chan" <mchan@broadcom.com>
To: "Jeff Mahoney" <jeffm@suse.com>
cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
In-Reply-To: <43FB9718.4050606@suse.com>
References: <20060220194337.GA21719@locomotive.unixthugs.org>
 <1140540260.20584.6.camel@rh4>
 <20060221.133947.05470613.davem@davemloft.net>
 <43FB9718.4050606@suse.com>
Date: Tue, 21 Feb 2006 13:57:28 -0800
Message-ID: <1140559048.20584.20.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006022109; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230312E34334642413435442E303031372D412D;
 ENG=IBF; TS=20060221233843; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006022109_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FE57B0836S1170469-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 17:41 -0500, Jeff Mahoney wrote:

> 
> dmesg after modprobe tg3:
> tg3.c:v3.49 (Feb 2, 2006)
> ACPI: PCI Interrupt 0000:0a:02.0[A] -> GSI 24 (level, low) -> IRQ 201
> Uhhuh. NMI received for unknown reason 21 on CPU 0.
> Dazed and confused, but trying to continue
> Do you have a strange power saving mode enabled?
> tg3_test_dma() Write the buffer failed -19
> tg3: DMA engine test failed, aborting.
> 

You're getting an NMI during tg3_init_one() which means that the NIC is
probably bad. I did a quick test on the same version of the 5701 NIC
with the same tg3 driver and it worked fine.

Please find out if the NIC is known to be bad. Thanks.



