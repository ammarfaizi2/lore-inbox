Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTKEXUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 18:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTKEXUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 18:20:04 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:22712 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263280AbTKEXUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 18:20:00 -0500
Message-ID: <3FA984C4.1030504@cyberone.com.au>
Date: Thu, 06 Nov 2003 10:16:20 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lmbench context switch regression
References: <3FA8ECF0.8020800@cyberone.com.au>
In-Reply-To: <3FA8ECF0.8020800@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> Hi,
> I'm seeing quite a large context switch speed regression as reported
> by lmbench when I patched from test9 to test9-mm2.
>
> The obvious thing I can see from the patch is the PF_DEAD 
> finish_task_switch
> change. I don't have time to investigate further tonight though.
>
> lmbench two 0 sized processes context switch times go from around 
> 1.80us to
> 2.60us on my PIII 650 (UP).


The regression is smaller when going from test9 to test9-bk. About .2us 
(10%).
It does not go away when reverting the PF_DEAD change. Maybe its just lucky
alignment?


