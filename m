Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVBYM3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVBYM3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 07:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVBYM3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 07:29:13 -0500
Received: from quark.didntduck.org ([69.55.226.66]:40656 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262678AbVBYM2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 07:28:17 -0500
Message-ID: <421F19E4.10600@didntduck.org>
Date: Fri, 25 Feb 2005 07:28:20 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf.c cleanups
References: <200502250059.j1P0xbDU006504@laptop11.inf.utfsm.cl>
In-Reply-To: <200502250059.j1P0xbDU006504@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Brian Gerst <bgerst@didntduck.org> said:
> 
>>- Make sprintf call vsnprintf directly
>>- use INT_MAX for sprintf and vsprintf
> 
> 
> This is the size limit on what is written. 4GiB sounds a bit extreme...

Sprintf has no limit, which is why it's generally bad to use it.  I just 
replaced an open coded ((~0U)>>1) value with the equivalent INT_MAX.

--
				Brian Gerst
