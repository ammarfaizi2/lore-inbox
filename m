Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbTDDGhk (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 01:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTDDGhk (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 01:37:40 -0500
Received: from flrtn-2-m1-133.vnnyca.adelphia.net ([24.55.67.133]:16769 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id S263425AbTDDGh3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 01:37:29 -0500
Message-ID: <3E8D2AD4.10701@tmsusa.com>
Date: Thu, 03 Apr 2003 22:48:52 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] acpi compile fix
References: <20030403130505.199294c7.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>ACPI is performing a spin_lock() on a `void *'.  That's OK when spin_lock is
>implemented via an inline function.  But when it is implemented via macros
>(eg, with spinlock debugging enabled) we get:
>
>drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
>drivers/acpi/osl.c:739: request for member `owner' in something not a structure or union
>
>So cast it to the right type.
>

Yep 2.5.66 is happy with my config now
and is running nicely - thanks for the fix!

Joe

