Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161142AbVICFWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbVICFWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbVICFWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:22:32 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:44178 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1161142AbVICFWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:22:31 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <4319330C.5030404@zytor.com>
Date: Fri, 02 Sep 2005 22:22:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org>
In-Reply-To: <20050903042859.GA30101@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> 
> I assume you are worried about the stuff under asm that ends up
> being included by nearly every header file in the world.  Of
> course asm must use double-underscore types.  But the thing is,
> the vast majority of the kernel headers live under
> linux/include/linux/ and do not use double-underscore types, they
> use kernel specific, non-underscored types such as s8, u32, etc.
> My copy of IEEE 1003.1 and my copy of ISO/IEC 9899:1999 both fail
> to prohibit using the shiny new ISO C99 type for the various
> #include <linux/*> header files, which is what I was suggesting.
> 
> The world would be so much nicer a place if user space were free
> to #include linux/* header files rather than keeping a
> per-project private copy of all kernel structs of interest.  And
> where these kernel headers would #include stdint.h and define
> their stucts in terms of ISO C99 types.  I see nothing at all in
> the standards preventing such a change,
> 

Exportable types need to be double-underscore types, because the header 
files in user space that would include them can generally not include 
<stdint.h>.

	-hpa
