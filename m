Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbULGIbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbULGIbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 03:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbULGIbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 03:31:33 -0500
Received: from main.gmane.org ([80.91.229.2]:17876 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261655AbULGIb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 03:31:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Re: 2.6.10-rc[2|3] protection fault on /proc/devices
Date: Tue, 07 Dec 2004 09:31:20 +0100
Message-ID: <41B56A58.8050404@gmx.net>
References: <41B4E70F.8040306@gmx.net> <20041206234044.51667e94.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81.223.124.22
User-Agent: Mozilla Thunderbird 0.9 (X11/20041128)
X-Accept-Language: en-us, en
In-Reply-To: <20041206234044.51667e94.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Georg Schild <dangertools@gmx.net> wrote:
> 
>>Since 2.6.10-rc2 I am having problems accessing /proc/devices. On 
>>startup some init-skripts access this node and print out a protection 
>>fault. i am having this on pcmcia and swap startup. My system is an 
>>amd64 @3000+ in an Acer Aspire 1501Lmi at 64bit mode running gentoo. 
>>.config is the same as on 2.6.10-rc1 which works good. cat on 
>>/proc/devices gives the same problems. The kernel has just a patch for 
>>wbsd (builtin mmc-cardreader) from Pierre Ossman in use, everything else 
>>is vanilla. Does anyone know of this issue and perhaps on how to solve this?
 >>
 >>
> How odd.  All I can think is that something has registered a zillion
> devices and get_blkdev_list() has run off the /proc page.  But then, it
> should have oopsed in sprintf()..
> 
> Still.  Please send a copy of your /proc/devices from 2.6.10-rc1 and also
> apply this:
>
> to 2.6.10-rc3 and see if that fixes it.  If so, please send the
> /proc/devices content from this kernel.
> 
> Beyond that, perhaps something scribbled on the data structures in there. 
> Setting CONFIG_SLAB_DEBUG and/or CONFIG_DEBUG_PAGEALLOC might turn
> something up.

I have tried now with applied patch against the vanilla-sources, that 
means without the wbsd-patch, nothing changed. same is with the 
wbsd-patch. i did a complete rebuild (make clean etc.) everytime. How 
can i enable some debugging?

