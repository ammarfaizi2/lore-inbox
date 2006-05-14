Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWENHb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWENHb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 03:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWENHb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 03:31:58 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:38025 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751365AbWENHb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 03:31:57 -0400
Message-ID: <4466DCE9.7010906@gmail.com>
Date: Sun, 14 May 2006 08:31:53 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 6/6] Remove some of the kmemleak false positives
References: <20060513155757.8848.11980.stgit@localhost.localdomain>	 <20060513160625.8848.76947.stgit@localhost.localdomain> <9a8748490605131221nbadedf4p8904d9627f61f425@mail.gmail.com>
In-Reply-To: <9a8748490605131221nbadedf4p8904d9627f61f425@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 13/05/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
>> +#ifdef CONFIG_DEBUG_MEMLEAK
>> +               /* avoid a false alarm. That's not a memory leak */
>> +               memleak_free(out);
>> +#endif
> 
> 
> Hmm, so eventually we are going to end up with a bunch of ussgly #ifdef
> CONFIG_DEBUG_MEMLEAK's all over the place?
> 
> Wouldn't it be better to just make memleak_free() an empty stub in the
> !CONFIG_DEBUG_MEMLEAK case?

Yes, I'll make empty stubs (Paul suggested this as well).

Catalin
