Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbVKPTaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbVKPTaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbVKPTaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:30:46 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:12514 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030453AbVKPTap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:30:45 -0500
Message-ID: <437B88D2.9060603@acm.org>
Date: Wed, 16 Nov 2005 13:30:26 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-6mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       openipmi-developer@lists.sourceforge.net
Subject: Re: [Openipmi-developer] [PATCH 2.6.15-rc] ipmi: missing NULL test
 for kthread
References: <20051116173123.GA25777@lists.us.dell.com>
In-Reply-To: <20051116173123.GA25777@lists.us.dell.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:

>On IPMI systems with BT interfaces, we don't start the kernel thread,
>so smi_info->thread is NULL.  Test for NULL when stopping the thread,
>because kthread_stop() doesn't, and an oops ensues otherwise.
>
>Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
>
>  
>
Yes, obvious fix, please apply.  I wish I had a system with a BT
interface :(.  Of course, then I'd have to find a place to put it, and
I'd have an unhappy wife...

-Corey
