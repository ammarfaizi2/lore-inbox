Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVAGMW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVAGMW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVAGMW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:22:59 -0500
Received: from fest.stud.feec.vutbr.cz ([147.229.9.16]:55819 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261386AbVAGMW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:22:58 -0500
Message-ID: <41DE7F20.4010502@stud.feec.vutbr.cz>
Date: Fri, 07 Jan 2005 13:22:56 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Park Lee <parklee_sel@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to understand and turn off such a oops
References: <20050107115011.24897.qmail@web51510.mail.yahoo.com>
In-Reply-To: <20050107115011.24897.qmail@web51510.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Park Lee wrote:
> Hi,
>   Sometimes, when I call kmalloc() in Linux kernel,
> the kernel always bring out a oops shown as following:
> 
> 
> Debug: sleeping function called from invalid context
> at mm/slab.c:1980
> in_atomic():1, irqs_disabled():0

You're calling kmalloc in a context where sleeping is not allowed. And 
kmalloc with the GFP_KERNEL flag can sleep. Use GFP_ATOMIC in that context.

Michal
