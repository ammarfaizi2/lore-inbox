Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWEXHMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWEXHMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWEXHMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:12:47 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:41130 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932632AbWEXHMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:12:46 -0400
Date: Wed, 24 May 2006 11:12:52 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David McCullough <david_mccullough@au.securecomputing.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ACRYPTO] New asynchronous crypto layer release.
Message-ID: <20060524071252.GA24694@2ka.mipt.ru>
References: <20060521131429.GA9789@2ka.mipt.ru> <20060523230443.GG15545@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060523230443.GG15545@beast>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 24 May 2006 11:12:53 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 09:04:43AM +1000, David McCullough (david_mccullough@au.securecomputing.com) wrote:
> 
> Hi Evgeniy,

Hello David.

> Just interested in the results you are getting below for
> comparison to what I see under OCF with Openswan.
> 
> What sort of hifn card were you using in the test below,
> was it a 7956 PCIX (ie., 64bit?)
> 
> How did you measure the throughput  ?

It is racoon transport setup with ESP4 only ecryption with AES-128 CBC
mode.

Hardware.
FC4 vanilla kernel 2.6.16-1.2069_FC4smp runs on P3 3 Ghz with HT
enabled, 512 Mb of RAM, sk98lin gigabit ethernet.
Acrypto kernel runs on Xeon 2.4 Ghz with HT enabled with 1Gb of RAM 
and e1000 gigabit ethernet adapter (in pci-x slot).
HIFN card is old 7955 (it was quite challenging to bring it to Russia
when I started acrypto developemnt several years ago, so no new toys) 
in PCI-X slot.
When HIFN driver is not loaded, asynchronous SW crypto provider is
loaded for one processor.

Benchmark is scp (yes, it encrypt packets too to simulate some real work
on hosts) of big files over the gigabit link.

> I can post the OCF numbers,  but it doesn't mean a lot
> unless it's a fair comparison :-)

That would be good :)

> Cheers,
> Davidm

-- 
	Evgeniy Polyakov
