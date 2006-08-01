Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWHADrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWHADrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWHADrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:47:46 -0400
Received: from terminus.zytor.com ([192.83.249.54]:50643 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932342AbWHADrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:47:45 -0400
Message-ID: <44CECED0.8010503@zytor.com>
Date: Mon, 31 Jul 2006 20:47:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de
Subject: Re: [PATCH] x86_64 built-in command line
References: <20060731171442.GI6908@waste.org> <20060801010652.GA17771@plexity.net>
In-Reply-To: <20060801010652.GA17771@plexity.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> On Jul 31 2006, at 12:14, Matt Mackall was caught saying:
>> Allow setting a command line at build time on x86_64. Compiled but not
>> tested.
> 
> Can we just make this into a generic option and put the relevant strcpy
> (strcat) in init/main.c. We've supported a default in-kernel command line
> on ARM for sometime now and I think it would be best to just have a single
> implementation.
> 

Yes on the generic option, no on putting it in init/main.c... on a lot 
of architectures, some parsing of the command line happens *very* early, 
sometimes even before the C code is invoked.

	-hpa
