Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbVKDPrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbVKDPrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbVKDPrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:47:04 -0500
Received: from [195.23.16.24] ([195.23.16.24]:44970 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1161146AbVKDPrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:47:02 -0500
Message-ID: <436B8271.7040809@grupopie.com>
Date: Fri, 04 Nov 2005 15:46:57 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: introduce mm/util.c for shared functions
References: <2.505517440@selenic.com> <20051103211357.072c5646.akpm@osdl.org>	 <20051104062455.GD4367@waste.org> <84144f020511040020n7ae5a460ud9ba5bbec9317748@mail.gmail.com>
In-Reply-To: <84144f020511040020n7ae5a460ud9ba5bbec9317748@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 11/4/05, Matt Mackall <mpm@selenic.com> wrote:
> 
>>Well, yes. But I decided not to do that now because I ended up wanting
>>to create mm/util.c anyway for kzalloc. I suspect we'll see other
>>helper functions like kzalloc and kstrdup down the road.
> 
> I prefer this as well. kstrdup() is _not_ a string operation but a
> special purpose memory allocator just like kzalloc() and kcalloc().

It is even worse than just personal preference.

Having kstrdup in lib/string was actually tried first, but there are 
archs that use lib/string for their boot code.

This boot code has no kmalloc available, so the dependency of kstrdup on 
kmalloc breaks the build for them if kstrdup is moved to lib/string.

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
