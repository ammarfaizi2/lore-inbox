Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSGYRke>; Thu, 25 Jul 2002 13:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSGYRkd>; Thu, 25 Jul 2002 13:40:33 -0400
Received: from 209-87-236-21.ottawa.storm.ca ([209.87.236.21]:17296 "EHLO
	xandros.com") by vger.kernel.org with ESMTP id <S316397AbSGYRkb>;
	Thu, 25 Jul 2002 13:40:31 -0400
Message-ID: <3D4038CF.4020501@xandros.com>
Date: Thu, 25 Jul 2002 13:43:43 -0400
From: Pat Suwalski <pats@xandros.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020610 Debian/1.0.0-1
X-Accept-Language: en
MIME-Version: 1.0
To: henrique@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: modversion clarification.
References: <3D4024A3.6030401@xandros.com> <200207251359.50615.henrique@cyclades.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

henrique wrote:
> When you try to load the module, the insmod will check if the symbols of your 
> module are the same of the current running kernel. If the symbols are the 
> same the module will be loaded. So you can use your module on all kernels 
> that have the same CRC for the kernel functions your module uses.

So then is that not opposite of what modversion says it does, which is 
to allow modules to be more comptible across multiple kernel versions?

Basically, the problem is that if module.h is included and MODVERSION is 
not defined, and the module wants to export symbols (EXPORT_SYMTAB is 
defined), then module.h automatically ifdefs modversions.h even if the 
kernel is not configured to use it (and thus the file does not exist).

--Pat

> As a matter of fact it happens seldomly as the kernel are always changing and 
> you have to recompile your module every time you change your kernel. But it 
> is still a very good idea.
> 
> regards
> Henrique

