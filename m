Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWIFPDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWIFPDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWIFPDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:03:15 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:42795 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751275AbWIFPDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:03:15 -0400
Message-ID: <44FEE3CF.7090603@sw.ru>
Date: Wed, 06 Sep 2006 19:05:51 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>
Subject: Re: [RFC][PATCH] fail kernel compilation in case of unresolved symbols
References: <44FD7FED.7000603@sw.ru> <20060905153159.GA13082@uranus.ravnborg.org> <20060905160104.GF9173@stusta.de>
In-Reply-To: <20060905160104.GF9173@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Sep 05, 2006 at 05:31:59PM +0200, Sam Ravnborg wrote:
> 
>>On Tue, Sep 05, 2006 at 05:47:25PM +0400, Kirill Korotaev wrote:
>>
>>>At stage 2 modpost utility is used to check modules.
>>>In case of unresolved symbols modpost only prints warning.
>>>
>>>IMHO it is a good idea to fail compilation process in case of
>>>unresolved symbols, since usually such errors are left unnoticed,
>>>but kernel modules are broken.
>>
>>The primary reason why we do not fail in this case is that building
>>external modules often result in unresolved symbols at modpost time.
>>
>>And there is many legitime uses of external modules that we shall support.

> Is there a way we can get this only for building the kernel itself?
> In this case an unresolved symbol is a real bug that should cause an 
> abort of the compilation.
IMHO for kernel linking will fail...

Don't you consider the kernel to be broken if suddenly one of your modules
began to have unresolved symbols?

> I'm often doing compile tests for the kernel, and the current warnings 
> are too easy to miss.
exactly. and I'm pretty sure, that vendors have the same problem.

Thanks,
Kirill
