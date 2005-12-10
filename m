Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVLISbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVLISbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVLISbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:31:40 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:62192 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964867AbVLISbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:31:39 -0500
Message-ID: <439A3047.7080505@acm.org>
Date: Fri, 09 Dec 2005 19:32:55 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] ipmi: panic generator ID
References: <20051209180305.GB29231@lists.us.dell.com>
In-Reply-To: <20051209180305.GB29231@lists.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this is correct, I can't shift bits :).

Thanks, Jordon and Matt.

-Corey

Matt Domsch wrote:

>The IPMI specifcation says the generator ID is 0x20, but that is for
>bits 7-1.  Bit 0 is set to specify it is a software event.  The
>correct value is 0x41.  Without this fix, panic events written into
>the System Event Log appear to come from an "unknown" generator,
>rather than from the kernel.
>
>Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
>Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
>Ack'd-by: Corey Minyard <minyard@acm.org>
>
>
>  
>

