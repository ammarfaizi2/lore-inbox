Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUAaGIX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 01:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUAaGIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 01:08:22 -0500
Received: from terminus.zytor.com ([63.209.29.3]:43403 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263185AbUAaGIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 01:08:21 -0500
Message-ID: <401B464C.50004@zytor.com>
Date: Fri, 30 Jan 2004 22:08:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: klibc list <klibc@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: long long on 32-bit machines
References: <4017F991.2090604@zytor.com> <16408.59474.427408.682002@cargo.ozlabs.ibm.com>
In-Reply-To: <16408.59474.427408.682002@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> H. Peter Anvin writes:
> 
> 
>>Does anyone happen to know if there are *any* 32-bit architectures (on 
>>which Linux runs) for which the ABI for a "long long" is different from 
>>passing two "longs" in the appropriate order, i.e. (hi,lo) for bigendian 
>>or (lo,hi) for littleendian?
> 
> 
> Are you are talking about passing arguments to a function?  PPC32
> passes long long arguments in two registers in the order you would
> expect (hi, lo), BUT you have to use an odd/even register pair.  In
> other words, if you have a function like this:
> 
> 	int foo(int a, long long b)
> 
> then a will be passed in r3 and b will be passed in r5 and r6, and r4
> will be unused.
> 

Does system calls follow the same convention?

	-hpa
