Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWENR4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWENR4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWENR4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:56:24 -0400
Received: from mail.aknet.ru ([82.179.72.26]:37639 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751351AbWENR4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:56:24 -0400
Message-ID: <44676F42.7080907@aknet.ru>
Date: Sun, 14 May 2006 21:56:18 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Segfault on the i386 enter instruction
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Andi Kleen wrote:
> Handling it like you expect would require to disassemble 
> the function in the page fault handler and it's probably not 
> worth doing that for this weird case.
Just wondering, is this case really that weird?
In fact, the check against %esp that the kernel
does, looks strange. I realize that it can catch a
(very rare) user-space bug of accessing below %esp, but
other than that it looks redundant (IMHO) and as soon as
it triggers the false-positives, what is it really good for?
Aren't the rlimit and the other checks of acct_stack_growth()
not enough, or am I missing something obvious?

