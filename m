Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266185AbUHFWY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUHFWY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266191AbUHFWY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:24:59 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:38130 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S266185AbUHFWY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:24:57 -0400
Message-ID: <41140654.3060609@am.sony.com>
Date: Fri, 06 Aug 2004 15:29:40 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is extern inline -> static inline OK?
References: <4112D32B.4060900@am.sony.com> <ceul43$sbv$1@terminus.zytor.com>
In-Reply-To: <ceul43$sbv$1@terminus.zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <4112D32B.4060900@am.sony.com>
> By author:    Tim Bird <tim.bird@am.sony.com>
> In newsgroup: linux.dev.kernel
> 
>>Pardon my ignorance...
>>
>>Under what conditions is it NOT OK to convert "extern inline"
>>to "static inline"?
>>
> 
> 
> When the code is broken if it doesn't inline.

Thanks!

 From what I have read, for either 'extern inline' or 'static inline'
the compiler is free to not inline the code. Is this wrong?

It is my understanding that...
In the 'static inline' case the compiler may create a function in the
local compilation unit. But in the 'extern inline' case an extern
non-inline function must exist. If the compiler decides not to inline
the function, and a non-inline function does not exist, you get a linker
error.  Are you saying that, therefore, 'extern inline' functions are
used (without definition of extern non-inline functions to back them)
in order to guarantee that NO non-inline version of the function exists?

Or are you saying that the non-inline version of the function may
be written differently than the inline version?

Sorry to be so dense... I really appreciate your help.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
