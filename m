Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWJRPF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWJRPF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWJRPF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:05:56 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:21875 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161120AbWJRPFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:05:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=E0OjIDdKrI2+6zO3S/pKo5hS1weJEhrOLJN3nioLRW1Hz4+s/Sdjj9SQdv7Oj7/rpcBgjn7CL4I8NnzmorSYOcbwltXZHqPohDMxqqAXe5DR0cVg06Fu0jf/4fHl0R+cjZaGWwJ7vRbnIIITCBTZ24tUlWIGZNTN7kPDwzKv5RI=  ;
Message-ID: <453642D1.1010302@yahoo.com.au>
Date: Thu, 19 Oct 2006 01:05:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM killer meets userspace headers
References: <20061018145305.GA5345@martell.zuzino.mipt.ru>
In-Reply-To: <20061018145305.GA5345@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> Despite mm.h is not being exported header, it does contain one thing
> which is part of userspace ABI -- value disabling OOM killer. So,
> a) export mm.h to userspace
> b) got OOM_DISABLE disable define out of __KERNEL__ prison.
> c) turn bound values suitable for /proc/$PID/oom_adj into defines and export
>    them too.
> d) put some headers into __KERNEL__ prison. It'd bizarre to include mm.h and
>    get capability stuff.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---

Seems fine. Silly question:

> +/* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
> +#define OOM_DISABLE (-17)
> +/* inclusive */
> +#define OOM_ADJUST_MIN (-16)
> +#define OOM_ADJUST_MAX 15

Why do you need the () for the -ves?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
