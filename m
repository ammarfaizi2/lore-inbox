Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291074AbSCKTz2>; Mon, 11 Mar 2002 14:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292087AbSCKTzS>; Mon, 11 Mar 2002 14:55:18 -0500
Received: from [195.63.194.11] ([195.63.194.11]:41995 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291074AbSCKTzI>; Mon, 11 Mar 2002 14:55:08 -0500
Message-ID: <3C8D0B56.7090505@evision-ventures.com>
Date: Mon, 11 Mar 2002 20:53:58 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: ide timer trbl ...
In-Reply-To: <Pine.LNX.4.44.0202231238060.1449-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> You guys probably already know but i'm still having problems with the ide
> timer in 2.5.5 :
> 
> hda: ide_set_handler: handler not null; old=c01c5e10, new=c01c5e10
> bug: kernel timer added twice at c01c7293.
> NFS: NFSv3 not supported.
> nfs warning: mount version older than kernel
> hda: ide_set_handler: handler not null; old=c01c5e10, new=c01c5e10
> bug: kernel timer added twice at c01c7293.

Hugh?

It would be helpfull if you could send me the System.map
corresponding to that, since this could make it clear
which particular timer function is involved.

lspci -v
hdparm -i /dev/hda

and so one are usefull as well of course.

I was already tempted to replace the above check by a BUG()...

Would you mind as well to just apply ide-clean-18 and ide-clean-19
on top of each other and recheck?


