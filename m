Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUDGSR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbUDGSR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:17:56 -0400
Received: from mail.daybyday.de ([213.191.85.38]:38652 "EHLO data.daybyday.de")
	by vger.kernel.org with ESMTP id S262279AbUDGSQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:16:27 -0400
In-Reply-To: <20040407022922.A841@den.park.msu.ru>
References: <3B75AEAB-8807-11D8-A1B6-000393C43976@postmail.ch> <20040407022922.A841@den.park.msu.ru>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C2D671CC-88BD-11D8-A1B6-000393C43976@postmail.ch>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Stefan Wanner <stefan.wanner@postmail.ch>
Subject: Re: 2.6.5-rc3: Parse error in traps.c on Alpha
Date: Wed, 7 Apr 2004 20:02:40 +0200
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you. I just upgraded to version 3.3.3 from the unstable tree... 
and it works!

Now, there is only one warning left. When a module is compiled I get 
something like this (for all modules!):

CC [M]  arch/alpha/kernel/srm_env.o
{standard input}: Assembler messages:
{standard input}:5: Warning: setting incorrect section attributes for 
.got

Any idea about that?

Stefan.


On 07.04.2004, at 00:29, Ivan Kokshaysky wrote:

> On Tue, Apr 06, 2004 at 10:16:05PM +0200, Stefan Wanner wrote:
>> I still have this problem in 2.6.5
> ...
>>> arch/alpha/kernel/traps.c: In function `opDEC_check':
>>> arch/alpha/kernel/traps.c:55: parse error before `['
> ...
>>> gcc version 2.95.4 20011002 (Debian prerelease)
>
> This can be compiled only with gcc version >= 3.1.
>
> Richard, should we explicitly state the minimal gcc
> version requirement for 2.6 on Alpha somewhere,
> or just change the opDEC inline asm to use older syntax?
> To me, both ways look acceptable.
>
> Ivan.
>

