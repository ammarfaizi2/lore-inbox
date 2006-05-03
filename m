Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWECBwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWECBwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 21:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWECBwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 21:52:51 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:35774 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S965068AbWECBwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 21:52:51 -0400
Message-ID: <44580CF2.7070602@tlinx.org>
Date: Tue, 02 May 2006 18:52:50 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: "Brian D. McGrew" <brian@visionpro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Too many levels of symbolic links
References: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Brian D. McGrew wrote:
> Because of the way our internal filesystem is setup, I'm seeing this
> error more and more.
>
> At one time, back in the early 2.4 days, I'd made a change to the kernel
> to all more links but I can't seem to find it again in 2.6.  Does anyone
> know off hand where this constant is defined???
>   
----
Is this what you are looking for?

include/linux/namei.h    MAX_NESTED_LINKS = 5

(used in fs/namei.c, where comment claims MAX_NESTING is equal to 8)


