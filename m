Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWDJGiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWDJGiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 02:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWDJGiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 02:38:08 -0400
Received: from cmsout03.mbox.net ([165.212.64.33]:56239 "EHLO
	cmsout03.mbox.net") by vger.kernel.org with ESMTP id S1750996AbWDJGiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 02:38:07 -0400
X-USANET-Source: 165.212.11.137  IN   lion@odcnet.com uadvg137.cms.usa.net
X-USANET-MsgId: XID630kDJgl68282X03
X-USANET-Auth: 82.81.211.211   AUTH lkalev@usa.net [192.168.0.101]
Message-ID: <4439FD3A.9060305@odcnet.com>
Date: Sun, 09 Apr 2006 23:37:46 -0700
From: Leonid Kalev <lion@odcnet.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rahul Karnik <rahul@genebrew.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Tracking down leaking applications
References: <b29067a0604090842h3bb11a88re9c175a467763c9f@mail.gmail.com>
In-Reply-To: <b29067a0604090842h3bb11a88re9c175a467763c9f@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Z-USANET-MsgId: XID754kDJgl50361X37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Karnik wrote:

>
>The process killed has been either httpd or cronolog so far. For now,
>I have upgraded to FC4's 2.6.16-1_1069 and added some swap, where
>previously there was none.
>
>Is there a way to:
>- confirm that it is a userspace and not a kernel issue?
>- track down the application that is leaking memory?
>  
>
This seems a bit off-topic for LKML, because you should *always* check 
user-space for memory leaks before blaming the kernel. A few things that 
can help you with your questions:
- the 'ps' utility, to see who eats the memory
- valgrind - an excellent tool for tracking down memory leaks (and other 
bugs, too). Comes with Fedora, but check the Web for a newer version.

Regards,

Leo.

>Thanks for the help,
>Rahul
>--
>Rahul Karnik
>rahul@genebrew.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

