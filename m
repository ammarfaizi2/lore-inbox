Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVCGIaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVCGIaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVCGIaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:30:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:32927 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261695AbVCGI36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:29:58 -0500
Message-ID: <422C0A6B.1060700@suse.de>
Date: Mon, 07 Mar 2005 09:01:47 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, barryn@pobox.com,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Bug 4298] swsusp fails to suspend if CONFIG_DEBUG_PAGEALLOC
 is   also enabled
References: <20050306030852.23eb59db.akpm@osdl.org>	<20050306225730.GA1414@elf.ucw.cz> <20050306195954.6d13cff9.akpm@osdl.org>
In-Reply-To: <20050306195954.6d13cff9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:

>> Okay, that is because low-level assembly requires PSE (4mb pages for
>> kernel) and DEBUG_PAGEALLOC disables that capability.
>> 
>> If you feel like rewriting assembly code to turn off paging (and thus
>> working with PSE), go ahead, but I do not think it is worth the
>> trouble.
>> 
>> OTOH we should at least tell people what went wrong, some people seen
>> same problem on VIA cpus... Please apply,
>> 
> 
> Isn't some Kconfig solution appropriate here?

Yes, but only for the CONFIG_DEBUG_PAGEALLOC case, it does not solve the
"cpu has no PSE" case for VIA CPUs. So the Kconfig solution is an extra
bonus.

    Stefan

