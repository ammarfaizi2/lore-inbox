Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWEWXEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWEWXEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 19:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWEWXEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 19:04:51 -0400
Received: from bne.snapgear.com ([203.143.235.140]:6543 "EHLO moreton.com.au")
	by vger.kernel.org with ESMTP id S932461AbWEWXEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 19:04:50 -0400
Date: Wed, 24 May 2006 09:04:43 +1000
From: David McCullough <david_mccullough@au.securecomputing.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ACRYPTO] New asynchronous crypto layer release.
Message-ID: <20060523230443.GG15545@beast>
References: <20060521131429.GA9789@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521131429.GA9789@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Evgeniy,

Just interested in the results you are getting below for
comparison to what I see under OCF with Openswan.

What sort of hifn card were you using in the test below,
was it a 7956 PCIX (ie., 64bit?)

How did you measure the throughput  ?

I can post the OCF numbers,  but it doesn't mean a lot
unless it's a fair comparison :-)

Cheers,
Davidm


Jivin Evgeniy Polyakov lays it down ...
> New asynchronous crypto layer acrypto [1] release.
> It includes new driver for HIFN 7955/7956 adapters,
> VIA padlock driver, driver for CE-InfoSys FastCrypt PCI card equipped
> with a SuperCrypt CE99C003B and
> dm-crypt and IPsec ESP4 engines ported to acrypto.
> 
> Psec ESP4 transport mode benchmark (scp):
>         2.6.16-1.2069_FC4smp -> vanilla 2.6.16-git: ~11.8 MB/s
> 	vanilla 2.6.16-git -> 2.6.16-1.2069_FC4smp: ~13.2 MB/s
> 
> 	2.6.16-1.2069_FC4smp -> acrypto SW 2.6.16: ~12.6 MB/s
> 	acrypto SW 2.6.16 -> 2.6.16-1.2069_FC4smp: ~13.5 MB/s
> 
> IPsec benchmark with HIFN driver:
> 	2.6.16-1.2069_FC4smp -> vanilla 2.6.16-git: ~11.8 MB/s
> 	vanilla 2.6.16-git -> 2.6.16-1.2069_FC4smp: ~13.2 MB/s
> 
> 	2.6.16-1.2069_FC4smp -> acrypto HIFN 2.6.16: ~13.2 MB/s
> 	acrypto HIFN 2.6.16 -> 2.6.16-1.2069_FC4smp: ~13.5 MB/s
> 
> As you might expect, CPU usage with HIFN driver and acrypto is noticebly
> less, since that setup is CPU limited for stock synchronous kernel
> setup (3Ghz P4 with HT enabled).
> Above numbers drift with the time, especially when machine running
> stock FC4 kernel overheats, and that numbers decrease to 12-13 MB/s.
> 
> One can find combined patchsets for 2.6.15 and 2.6.16 trees which
> include acrypto with SW crypto provider, dm-crypt and IPsec engines
> at acrypto homepage [1].
> 
> Credits.
> Yakov Lerner for great testing and bug-hunting.
> Michal Ludvig for original VIA padlock and fcrypt drivers.
> 
> 
> Thank you.
> 
> 1. Asynchronous crypto layer acrypto.
> http://tservice.net.ru/~s0mbre/old/?section=projects&item=acrypto
> 
> -- 
> 	Evgeniy Polyakov
> -
> To unsubscribe from this list: send the line "unsubscribe linux-crypto" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
David McCullough,  david_mccullough@securecomputing.com,   Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com
