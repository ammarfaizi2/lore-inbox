Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTLWHFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 02:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTLWHFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 02:05:19 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:57224 "HELO
	develer.com") by vger.kernel.org with SMTP id S264968AbTLWHFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 02:05:13 -0500
Message-ID: <3FE7E923.9030106@develer.com>
Date: Tue, 23 Dec 2003 08:05:07 +0100
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mtd@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix static build of drivers/mtd/chips/jedec_probe.c
References: <3FE7D92A.1090205@develer.com> <20031222225442.764d8d0e.akpm@osdl.org>
In-Reply-To: <20031222225442.764d8d0e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Bernardo Innocenti <bernie@develer.com> wrote:
> 
>>Hello,
>>
>>one liner fix for building jedec_probe statically in m68knommu and possibly other archs.
>>
>>Applies to 2.6.0.
>>
>>
>>--- drivers/mtd/chips/jedec_probe.c	2003-12-23 06:50:51.842514068 +0100
>>+++ drivers/mtd/chips/jedec_probe.c.orig	2003-12-23 06:51:15.512685112 +0100
>>@@ -8,7 +8,6 @@
>> 
>> #include <linux/config.h>
>> #include <linux/module.h>
>>-#include <linux/init.h>
>> #include <linux/types.h>
>> #include <linux/kernel.h>
>> #include <asm/io.h>
> 
> Inclusion of init.h shouldn't break anything.   What is the error?

OOPS, I reversed the diff by mistake.  The patch was supposed to
*add* that line ;-)

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/


