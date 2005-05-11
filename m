Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVEKXVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVEKXVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 19:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVEKXVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 19:21:17 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:17675 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261316AbVEKXVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 19:21:15 -0400
Date: Thu, 12 May 2005 01:10:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Manfred Schwarb <manfred99@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.30-hf1 do_IRQ stack overflows
Message-ID: <20050511231016.GC18600@alpha.home.local>
References: <4699.1115820286@www19.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4699.1115820286@www19.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 11, 2005 at 04:04:46PM +0200, Manfred Schwarb wrote:
> [Somehow the original message didn't made it to the lkml, so here another
> try]
> 
> 
> Hi,
> with recent versions of the 2.4 kernel (Vanilla), I get an increasing 
> amount of do_IRQ stack overflows.
> This night, I got 3 of them.
> With 2.4.28 I got an overflow about twice a year, with 2.4.29 nearly 
> once a month and with 2.4.30 nearly every day 8-((

stupid question : have you tried reverting to older versions to check
if the problem follows kernel upgrades or if something is ageing badly
in your machine ?

> My layout: Pentium4 HT SMP, raid1 on a promise card, driven by 
> libata_promise, everything using reiserfs, heavy nfs and network traffic, 
> with a Linksys (tulip) and a Realtek (8139too) NIC.

do you mean that you tested both with tulip and realtek and that the
problem happens with both of them, or that your machine needs those
two NICs simultaneously ? Using a realtek with heavy NFS and network
traffic seems somewhat odd, eventhough the driver is rather stable.

> The used 2.4.30-hf1 is pure Vanilla.
> 
> Below my three overflow messages. Would the stack reduction patches of 
> Badari Pulavarty help in my case? 

I don't know. I suspect that it might delay the problem but not remove
it.

Regards,
Willy

