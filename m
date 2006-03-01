Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWCAVfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWCAVfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWCAVfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:35:50 -0500
Received: from main.gmane.org ([80.91.229.2]:32415 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751215AbWCAVft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:35:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [PATCH] mm: implement swap prefetching (v26)
Date: Wed, 1 Mar 2006 22:34:01 +0100
Message-ID: <1h8uuytzsq106$.k1fw2sw35o89$.dlg@40tude.net>
References: <200602172235.40019.kernel@kolivas.org> <3b0ffc1f0602170618u7a1ad877s337de33c0a8f44f9@mail.gmail.com> <200602180126.58519.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-48-150.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Cc: ck@vds.kolivas.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Hope I managed to keep the CC list intact ... I'm using a newsreader
to follow LKML from gmane]

On Sat, 18 Feb 2006 01:26:57 +1100, Con Kolivas wrote:

> On Saturday 18 February 2006 01:18, Kevin Radloff wrote:
>> On 2/17/06, Con Kolivas <kernel@kolivas.org> wrote:
>>> Added disabling of swap prefetching when laptop_mode is enabled.
>>
>> Why bother with this? As someone commented in a previous thread,
>> wouldn't it be better to let the laptop_mode script handle it?
> 
> The discussion was about what size to make the swap prefetching. Since the 
> size is not user tunable any more that is not the case. I had an offlist 
> discussion with Bart Samwel about it and basically if your drive spins down 
> at 5 seconds (which is what commonly happens with laptop mode) you will never 
> have an opportunity to prefetch. This means swap prefetch will basically 
> always spin up the drive nullifying laptop mode. On balance if you care about 
> power more than anything to actually set laptop mode I suspect you wont want 
> prefetch using any more power.

Would it make any sense to just delay swap prefetch execution and/or
analysis to "as soon as the HD is spun up/just before the HD is spun
down", rather than completely disabling it?

-- 
Giuseppe "Oblomov" Bilotta

Hic manebimus optime

