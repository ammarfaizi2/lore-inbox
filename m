Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266266AbUAIBBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266374AbUAIBBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:01:12 -0500
Received: from ip214-49.coastside.net ([207.213.214.33]:11475 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S266266AbUAIBBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:01:04 -0500
Mime-Version: 1.0
Message-Id: <p0602045cbc23ac7a1ada@[192.168.0.3]>
In-Reply-To: <20040109004525.GB545@alpha.home.local>
References: <20040107200556.0d553c40.skraw@ithnet.com>
 <20040107210255.GA545@alpha.home.local>
 <3FFCC430.4060804@candelatech.com>
 <20040108091441.3ff81b53.skraw@ithnet.com>
 <20040108084758.GB9050@alpha.home.local>
 <p0602042fbc2347a37845@[192.168.0.3]>
 <20040109004525.GB545@alpha.home.local>
Date: Thu, 8 Jan 2004 17:00:42 -0800
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
From: Jonathan Lundell <jlundell@lundell-bros.com>
Subject: Re: Problem with 2.4.24 e1000 and keepalived
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:45am +0100 1/9/04, Willy Tarreau wrote:
>  > It's unfortunate that the two conditions are conflated by most net drivers.
>
>IMHO, saying "most net drivers" is unfair : tg3, tulip, 3c59x, starfire,
>realtek, sis900, dl2k, pcnet32, and IIRC sunhme are OK. eepro100 is nearly
>OK but has this annoying bug, and only older 10 Mbps drivers don't report
>their status, often because the chip itself doesn't know.

I'm sure you're right; I should have said most of the drivers that 
I'm using (including e100 &e1000).

My impression, though, is that there's a trend to use 
netif_carrier_ok() to check the link in newish drivers (of course, 
it's author-choice, not universal), and that the netif_carrier_ok() 
is generally implemented to be dependent on the interface being 
(logically) up.

It'd be nice if we could define link state reporting to be 
independent of logical up/down state, at least for drivers & devices 
capable of making the distinction.
-- 
/Jonathan Lundell.
