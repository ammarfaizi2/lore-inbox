Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268319AbUHFWa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268319AbUHFWa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268318AbUHFWa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:30:26 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:15265 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S268316AbUHFWaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:30:13 -0400
Message-ID: <41140643.70704@zytor.com>
Date: Fri, 06 Aug 2004 15:29:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is extern inline -> static inline OK?
References: <4112D32B.4060900@am.sony.com> <ceul43$sbv$1@terminus.zytor.com> <41140654.3060609@am.sony.com>
In-Reply-To: <41140654.3060609@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird wrote:
> 
> Thanks!
> 
>  From what I have read, for either 'extern inline' or 'static inline'
> the compiler is free to not inline the code. Is this wrong?
> 
> It is my understanding that...
> In the 'static inline' case the compiler may create a function in the
> local compilation unit. But in the 'extern inline' case an extern
> non-inline function must exist. If the compiler decides not to inline
> the function, and a non-inline function does not exist, you get a linker
> error.  Are you saying that, therefore, 'extern inline' functions are
> used (without definition of extern non-inline functions to back them)
> in order to guarantee that NO non-inline version of the function exists?
> 

Yes; the final link will fail with an undefined symbol if "extern inline" 
fails to inline.

	-=hpa
