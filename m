Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263981AbUD2Jaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263981AbUD2Jaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 05:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbUD2Jae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 05:30:34 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:46469 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S263981AbUD2Ja3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 05:30:29 -0400
Message-ID: <4090CB31.6090300@softhome.net>
Date: Thu, 29 Apr 2004 11:30:25 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.5+ (Macintosh/20040414)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@user.it.uu.se>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
References: <1PX8S-5z2-23@gated-at.bofh.it>
In-Reply-To: <1PX8S-5z2-23@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch fixes three warnings from gcc-3.4.0 in 2.6.6-rc3:
> - drivers/char/ftape/: use of cast-as-lvalue
>  		if (get_unaligned((__u32*)ptr)) {
> -			++(__u32*)ptr;
> +			ptr += sizeof(__u32);
>  		} else {

   Can anyone explain what is the problem with this?
   To me it seems pretty ligitimate code - why it was outlawed in gcc 3.4?

   Previous code was agnostic to type of ptr, but you code presume ptr 
being char pointer (to effectively increment by 4 bytes).

   So what all this buzz about?
