Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266530AbUBMOlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUBMOlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:41:08 -0500
Received: from gizmo05bw.bigpond.com ([144.140.70.15]:48608 "HELO
	gizmo05bw.bigpond.com") by vger.kernel.org with SMTP
	id S266530AbUBMOlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:41:02 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
Date: Sat, 14 Feb 2004 00:41:17 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>
References: <200402120122.06362.ross@datscreative.com.au> <402CB24E.3070105@gmx.de>
In-Reply-To: <402CB24E.3070105@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402140041.17584.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 21:17, Prakash K. Cheemplavam wrote:
> Hi,
> 
> I am just testing this patch with latest 2.6.3-rc2-mm1. It works in that 
> sense, that my machine doesn't lock up of APIC issue. (If it locks up - 
> hasn't done yet - then because of something else, I am currently 
> discssing it in another thread...)
> 
> But it doesn't work in the sense of cooling my machine down. Though 
> athcool reports disconnect is activated it behaves like it is not, ie, 
> turning disconnect off makes no difference in temperatures. Your old 
> tack patch in conjunction with 2.6.2-rc1 (linus) works like a charm, ie 
> no lock-ups and less temp.
> 

Thanks Prakash for testing it and spotting thermal problem.

Here are some temperatures from my machine read from the bios on reboot.
I gave it minimal activity for the minutes prior to reboot.

Win98, 47C
XPHome, 42C
Patched Linux 2.4.24 (1000Hz), 40C
Patched Linux 2.6.3-rc1-mm1, 53C  OUCH!

Sorry, I will have to go through my latest patch and see why the temp differs
so much between 2.4 and 2.6. I currently use patched 2.4.24 with Suse 8.2 for
convenience. When it stopped the lockups on 2.6 I thought the 2.6 was
working the same way. 

Daniel - I think you patched your 2.6 too. I assume it is also hot?


> Any idea? I haven't taken out the apic_tack line, but I have added the 
> idle=... line. Should that be a problem? I mean the apic_tack should 
> safely be ignored, isn't it? Since I swap kernels quite often, I am too 
> lazy to edit the boot line every time...

Correct, apic_tack will be ignored if the apic.c is not patched with my apic
ack delay patch.

Ross.

> 
> Prakash
> 
> 
> 

