Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWHVWsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWHVWsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWHVWsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 18:48:09 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:40145 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750795AbWHVWsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 18:48:08 -0400
Message-ID: <44EB8B2A.8030603@student.ltu.se>
Date: Wed, 23 Aug 2006 00:54:34 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Prajakta Gudadhe <pgudadhe@nvidia.com>, jeff@garzik.org,
       linux-kernel@vger.kernel.org
Subject: Generic booleans in -mm (was: Re: [PATCH] Sgpio support in sata_nv)
References: <1156209426.2840.15.camel@dhcp-172-16-174-114.nvidia.com> <20060821224457.65de5111.akpm@osdl.org>
In-Reply-To: <20060821224457.65de5111.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Mon, 21 Aug 2006 18:17:06 -0700
>Prajakta Gudadhe <pgudadhe@nvidia.com> wrote:
>  
>
[snip]

>>...
>>
>>+
>>+static bool nv_sgpio_update_led(struct nv_sgpio_led *led, bool *on_off)
>>    
>>
>
>Please remove the new private implementation of `bool' and just use `int'. 
>There's ongoing discussion about how to do a kernel-wide implementation of
>bool, and adding new driver-private ones now just complicates that.
>  
>
Well, the discussion seem to have quiet down (so time to start it up 
again ;) ). But would you take a patch for a generic implementation of 
bool/false/true? I sent one 29th of July with no complaints or 
suggestions. I am happy to send it again.

About this patch, isn't better to leave the 'bool'-type if there is a 
will to make a common boolean? Easier to find and convert a local 
definition of bool then finding functions who are boolean, but decleard 
as some kind of integer.

Just a thought
/Richard Knutsson

