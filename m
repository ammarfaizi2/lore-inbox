Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSJMQ6Z>; Sun, 13 Oct 2002 12:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJMQ6Z>; Sun, 13 Oct 2002 12:58:25 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:58257 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261549AbSJMQ6Z>;
	Sun, 13 Oct 2002 12:58:25 -0400
Message-ID: <3DA9A796.4070600@colorfullife.com>
Date: Sun, 13 Oct 2002 19:04:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from
 open_kmem
References: <3DA985E6.6090302@colorfullife.com>	<87adliuyp6.fsf@goat.bogus.local> <3DA99A8B.5050102@colorfullife.com> <873crauw1m.fsf@goat.bogus.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:
> 
> Now, I have to run this process as root, regardless of filesystem
> permissions. So, if I trust this particular process with full
> privileges now, there's no problem in reducing its power a little bit.
> 
What about writing a small wrapper application that drops all priveleges 
except CAP_RAWIO, switches to user to the user you want, then execs the 
target application that needs to access /dev/kmem?

Or store the capabilities in the filesystem, but I don't know which 
filesystem supports that.

--
	Manfred

