Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUGMNEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUGMNEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUGMNEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:04:12 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:3738 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S264960AbUGMNEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:04:05 -0400
Message-ID: <40F3DDC4.7060104@isg.de>
Date: Tue, 13 Jul 2004 15:04:04 +0200
From: Lutz Vieweg <lkv@isg.de>
Organization: Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040322 wamcom.org
X-Accept-Language: de, German, en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: How to find out which pages were copied-on-write?
References: <40EACC0C.6060606@isg.de> <20040709113125.GA8897@lnx-holt.americas.sgi.com> <40EF0346.4040407@isg.de> <40EFA4C8.1050409@metaparadigm.com> <40F2C882.7070406@isg.de> <40F36216.1080603@metaparadigm.com>
In-Reply-To: <40F36216.1080603@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:

>> But wouldn't that introduce a significant overhead and undermine all 
>> of the
>> nice advantages the kernel might have in scheduling I/O operations?
>  
> Not really. Plain read/write IO is generally faster than mmap IO anyway.

Well, that was my result, too, when I measured mmap() vs. read()/write()
with the 2.4.x kernels, however, I was quite impressed recently when
I measured write operations with MAP_SHARED regions under 2.6.7
(CPU x86_64), they were not at all slower than ordinary write()s.
(congratulations to the involved kernel hackers on that! :-)

> You don't use mmap for speed but rather for convenience.

But isn't an advantage with mmap() that there's no need for the kernel
to copy what is to be written to a dedicated buffer? The kernel
could initiate DMA writes directly from the working memory...

Regards,

Lutz Vieweg


