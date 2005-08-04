Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVHDGBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVHDGBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVHDGBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:01:55 -0400
Received: from terminus.zytor.com ([209.128.68.124]:16592 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261853AbVHDGBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:01:51 -0400
Message-ID: <42F1AF35.2080700@zytor.com>
Date: Wed, 03 Aug 2005 23:01:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name
Subject: Re: [PATCH] 1/5 more-asm-cleanup
References: <200508040043.j740h4wB004166@zach-dev.vmware.com> <42F165BC.9030504@zytor.com> <42F18638.5070108@vmware.com>
In-Reply-To: <42F18638.5070108@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> Please explain why this is a reject after looking at the cpuid macro.  
> It changed recently.  Note 0 -> %ecx.

Then just use cpuid_eax(4)?  Or do those macros not behave that way?

> Would you prefer that I call cpuid_count and pass an explicit zero 
> parameter for ecx?

I guess I really don't like the implicit zero when it matters, so yes.

	-hpa
