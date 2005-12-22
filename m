Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbVLVX3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVLVX3C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbVLVX3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:29:01 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:10503 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030325AbVLVX3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:29:00 -0500
Date: Fri, 23 Dec 2005 00:28:55 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Conio sandiago <coniodiago@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Un aligned addresses
Message-ID: <20051222232855.GO15993@alpha.home.local>
References: <993d182d0512212236u525b6f25wf1dcaae9c389537f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993d182d0512212236u525b6f25wf1dcaae9c389537f@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 12:06:46PM +0530, Conio sandiago wrote:
> Hi all
> i have a embedded monta vista linux running.
> i have developed a ethernet driver.
> Its working Ok,
> But i am facing some problem with the throughput.
> 
> After a lot of observation ,
> i observed that i am getting un-aligned addresses of the data payload
> from the TCP/IP stack.because of this problem i always have to do
> memcpy to a word aligned buffer,because of which throughput is reduced
> significantly.
>
> Does anybody has some solution for this.

I guess your driver is not working that much OK yet. Many (most)
ethernet boards today will align the IP header on a 4 or 16 bytes boundary.
By default, the ethernet header being 14 bytes, it unaligns the IP header.
But some boards will leave a hole between those. Probably that your driver
needs to tell the hardware to do this. Or maybe you can program the DMA
to get on 4x+2 so that IP gets aligned ?

Anyway, I don't know whether I'm loosing my time because last time
you sent such a report about your driver, I asked for a little more
precisions, which I never received.

> Regards
> conio

Willy

