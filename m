Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUA1TJl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUA1TJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:09:41 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:50188 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266110AbUA1TJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:09:39 -0500
Message-ID: <401809B2.70907@techsource.com>
Date: Wed, 28 Jan 2004 14:12:50 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: klibc list <klibc@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: long long on 32-bit machines
References: <4017F991.2090604@zytor.com>
In-Reply-To: <4017F991.2090604@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



H. Peter Anvin wrote:
> Hi all,
> 
> Does anyone happen to know if there are *any* 32-bit architectures (on 
> which Linux runs) for which the ABI for a "long long" is different from 
> passing two "longs" in the appropriate order, i.e. (hi,lo) for bigendian 
> or (lo,hi) for littleendian?
> 
> I'd like to switch klibc to use the 64-bit file ABI thoughout, but it's 
> a considerable porting effort, and I'm trying to figure out how to best 
> manage it.
> 

I don't know how it is for GCC, but when using the Sun compiler, "long 
long" for 32-bit is low-high, while "long long" (or just long) for 
64-bit is high-low.  This has been an annoyance to me.  :)

