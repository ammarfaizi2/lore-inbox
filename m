Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVH2SVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVH2SVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVH2SVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:21:31 -0400
Received: from hq.tensilica.com ([65.205.227.29]:57516 "EHLO
	mailapp.tensilica.com") by vger.kernel.org with ESMTP
	id S1751274AbVH2SVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:21:31 -0400
Message-ID: <43135211.50109@tensilica.com>
Date: Mon, 29 Aug 2005 11:21:05 -0700
From: Chris Zankel <zankel@tensilica.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: We also need to get rid of verify_area in entry.S
References: <200508291954.27026.jesper.juhl@gmail.com>
In-Reply-To: <200508291954.27026.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper,

Thanks for the patches. I'll take a look at the entry.S one and will 
pass it along to Andres, and will incorporate the signal.c patch.

I am currently working on the system call interface and am removing the 
non-rt signal calls, so the signal.c patch probably doesn't apply 
cleanly anymore.

Thanks,
~Chris

Jesper Juhl wrote:
> In addition to the patch I sent a few minutes ago, there's one last reference
> to verify_area left in xtensa. It's in arch/xtensa/kernel/entry.S, and I'm 
> going to need your help to get rid of that one since that code is over my head
> and I assume that the naive approach below would just break it : 
