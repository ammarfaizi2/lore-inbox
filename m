Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264707AbUEEPu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264707AbUEEPu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 11:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264714AbUEEPu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 11:50:26 -0400
Received: from [195.23.16.24] ([195.23.16.24]:60870 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264707AbUEEPuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 11:50:12 -0400
Message-ID: <40990C78.70605@grupopie.com>
Date: Wed, 05 May 2004 16:47:04 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: marcus hall <marcus@tuells.org>, linux-kernel@vger.kernel.org
Subject: Re: mmap returns incorrect data
References: <20040429231243.GA8216@bastille.tuells.org> <20040430004705.A13006@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.3; VDF: 6.25.0.48; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> ....
> This is an IDE driver bug - it performs PIO but does not ensure that the
> individual pages are properly flushed to RAM before telling the kernel
> that the IO is complete.  (If someone wants to disagree, look at how
> rd.c does flush_dcache_page, and see previous discussions on lkml
> concerning this.)

 From what I could google from previous discussions, this bug affects ARM 
architectures but not x86. Am I correct in assuming this?

Please note that I'm not implying that since it doesn't affect x86, then it's 
ok. I've already tried linux on an iPaq 3970 and it runs great! I really feel 
that one of the Linux's strenghts is that it can run almost anywhere :)

It is just that I'm responsible for a project where we use a compact flash as 
storing device on an x86 system, and I would sleep better if this bug doesn't 
affect our system directly.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

