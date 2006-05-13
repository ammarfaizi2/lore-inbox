Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWEMVUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWEMVUh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 17:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWEMVUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 17:20:37 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:401 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751355AbWEMVUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 17:20:37 -0400
Date: Sat, 13 May 2006 23:20:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 4/6] Add kmemleak support for i386
In-Reply-To: <9a8748490605131124i236227a9s3a47a070cfc308a7@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0605132315370.11638@yvahk01.tjqt.qr>
References: <20060513155757.8848.11980.stgit@localhost.localdomain> 
 <20060513160612.8848.95311.stgit@localhost.localdomain>
 <9a8748490605131124i236227a9s3a47a070cfc308a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [snip]
>> +static inline unsigned long arch_call_address(void *frame)
>> +{
>> +       return *(unsigned long *) (frame + 4);
>
>      return *(unsigned long *)(frame + 4);

I would like to point out that a __bulitin_return_address(immediate int) 
and __builtin_frame_address(immediate int) exist (but they can 
unfortunately not be used with variables even though that would not pose 
much of a problem on x86).


>> +static inline void *arch_prev_frame(void *frame)
>> +{
>> +       return *(void **) frame;
>
>      return *(void **)frame;
>



Jan Engelhardt
-- 
