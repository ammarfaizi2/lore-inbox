Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWACJti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWACJti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 04:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWACJti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 04:49:38 -0500
Received: from [202.67.154.148] ([202.67.154.148]:37827 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1750868AbWACJth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 04:49:37 -0500
Message-ID: <43BA48B2.6080402@ns666.com>
Date: Tue, 03 Jan 2006 10:49:38 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hangcheck: hangcheck value past margin!
References: <43BA43E9.2090106@ns666.com> <1136280694.2942.19.camel@laptopd505.fenrus.org>
In-Reply-To: <1136280694.2942.19.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-01-03 at 10:29 +0100, Mark v Wolher wrote:
> 
>>Hiya guys,
>>
>>
>>I'm getting the msg "hangcheck: hangcheck value past margin!" every few
>>minutes in the logs. It started all of a sudden. The kernel is a vanilla
>>2.6.14.5 on a remote box.
>>
>>What could this mean ?
> 
> 
> it means you enabled the hangcheck timer watchdog, and it seems to think
> the kernel is too busy or losing time ;)
> Did you mean to enable that watchdog?
> 

Yes, it's indeed enabled, i just remembered when you mentioned the word
"timer" hehe

But the system is not processing a heavy load. Here is a capture with top:

top - 17:47:47 up 4 days, 18:58,  1 user,  load average: 0.35, 0.16, 0.05
Tasks:  88 total,   3 running,  85 sleeping,   0 stopped,   0 zombie
Cpu(s): 20.8% us,  0.0% sy,  0.0% ni, 78.9% id,  0.0% wa,  0.0% hi,  0.3% si
Mem:    513484k total,   498216k used,    15268k free,   140744k buffers
Swap:  1461872k total,        0k used,  1461872k free,   153608k cached

the "idle" percentage goes from 65 % to 95 %

