Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTEOFlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 01:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTEOFlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 01:41:04 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:48657 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S263854AbTEOFlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 01:41:03 -0400
Message-Id: <200305150545.h4F5j2u27109@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: techstuff@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Posible memory leak!?
Date: Thu, 15 May 2003 08:51:42 +0300
X-Mailer: KMail [version 1.3.2]
References: <200305131415.37244.techstuff@gmx.net> <200305140650.h4E6oCu04880@Port.imtp.ilyichevsk.odessa.ua> <200305141012.53779.techstuff@gmx.net>
In-Reply-To: <200305141012.53779.techstuff@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2003 17:12, Boris Kurktchiev wrote:
> heh this is very interesting.... top b n1 reports this:
> top - 10:08:24 up 16:36,  2 users,  load average: 0.16, 0.19, 0.08
> Tasks:  62 total,   1 running,  60 sleeping,   0 stopped,   1 zombie
> Cpu(s):  12.3% user,   5.1% system,   0.0% nice,  82.6% idle
> Mem:    385904k total,   381572k used,     4332k free,   137244k
> buffers Swap:   128512k total,    20012k used,   108500k free,  
> 126168k cached

Typical. So what makes you think kernel leaks memory?

BTW, which version of procps do you have? Mine is 2.0.10,
2.0.11 already exists.

> while gkrellm reports that my RAM used is 95MB. now this is
> interesting....

gkrellm must be subtracting something from MemTotal trying
to account for fact that large part of RAM is used as a cache.
You may consult its source.
--
vda
