Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267193AbRGKD0W>; Tue, 10 Jul 2001 23:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267195AbRGKD0M>; Tue, 10 Jul 2001 23:26:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:25104 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267193AbRGKD0E>; Tue, 10 Jul 2001 23:26:04 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: new IPC mechanism ideas
Date: 10 Jul 2001 20:25:40 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9iggvk$ndh$1@cesium.transmeta.com>
In-Reply-To: <20010711014918.76554.qmail@web14404.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010711014918.76554.qmail@web14404.mail.yahoo.com>
By author:    Rajeev Bector <rajeev_bector@yahoo.com>
In newsgroup: linux.dev.kernel
> 
> We are planning to develop a new IPC mechanism based on shared
> memory. The memory is allocated by a device driver in the kernel and
> mapped to various processes read only. Processes talk to the driver
> to write to the memory but they can directly read the memory (so its
> a 1-copy IPC mechanism).
> 
> We also want to make this IPC mechanism persistent across
> application restarts. So that if an application crashes, when it
> comes back up, it can remap to its old queues and get its messages.
> 
> Does anyone have experiences building such a mechanism ? Any
> pointers to reading material would be really appreciated ?
> 

Why not just use mmap() on a file?  That way you can even make it
zero-copy.  Otherwise, mmap() readonly in all but one process ("the
driver").

Nothing needed in the kernel that isn't already there...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
