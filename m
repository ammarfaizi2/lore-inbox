Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWH3S7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWH3S7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWH3S7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:59:15 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56787 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751317AbWH3S7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:59:14 -0400
Message-ID: <44F5DFD4.3090602@zytor.com>
Date: Wed, 30 Aug 2006 11:58:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <44F1F356.5030105@zytor.com>	<44F3555F.6060306@zytor.com>	<20060830194942.12cbf169@localhost>	<200608301856.11125.ak@suse.de> <20060830200638.504602e2@localhost>
In-Reply-To: <20060830200638.504602e2@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> On Wed, 30 Aug 2006 18:56:11 +0200
> Andi Kleen <ak@suse.de> wrote:
>> IA64 booting is completely different. I don't think it should 
>> be in this patch. At least you would need to check with the IA64
>> maintainer first.
> 
> OK... no problem.
> 
>> And the other thing is that this will cost memory. Either make
>> it dependend on !CONFIG_SMALL or fix the boot code to save the 
>> command line into a kmalloc'ed buffer of the right size and __init 
>> the original one
> 
> I don't mind doing either... Any preference for one of them? The
> kmalloc approach seems nicer..
> 

The kmalloc approach seems to be The Right Thing.

	-hpa
