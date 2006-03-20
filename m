Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWCTTEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWCTTEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWCTTEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:04:22 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:16589 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964833AbWCTTEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:04:22 -0500
Message-ID: <441EFCB0.6020007@garzik.org>
Date: Mon, 20 Mar 2006 14:04:16 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: joe.korty@ccur.com
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <20060320171905.GA4228@tsunami.ccur.com>
In-Reply-To: <20060320171905.GA4228@tsunami.ccur.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:
> Git patch 52dfa9a64cfb3dd01fa1ee1150d589481e54e28e
> 
> 	[PATCH] move rtc_interrupt() prototype to rtc.h
> 
> broke strace(1) builds.  The below moves the kernel-only additions lower,
> under the already provided #ifdef __KERNEL__ statement.
> 
> 
>  2.6.16-jak/include/linux/rtc.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

strace should be using sanitized versions of the kernel headers, not 
directly including them verbatim...

	Jeff



