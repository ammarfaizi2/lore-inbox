Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTKJN5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTKJN5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:57:17 -0500
Received: from gate.corvil.net ([213.94.219.177]:43533 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S263614AbTKJN5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:57:15 -0500
Message-ID: <3FAF995F.70406@draigBrady.com>
Date: Mon, 10 Nov 2003 13:57:51 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
References: <E1AJ994-0002xM-00@gondolin.me.apana.org.au> <1068469674.734.80.camel@cube> <3FAF9335.9010801@draigBrady.com> <20031110133746.GB32637@suse.de>
In-Reply-To: <20031110133746.GB32637@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Nov 10 2003, P@draigBrady.com wrote:
> 
>>Albert Cahalan wrote:
>>
>>>Besides, the kernel load average was changed to
>>>include processes waiting for IO. It just plain
>>>makes sense to mix CPU usage with IO usage by
>>>default. Wanting different niceness for CPU
>>>and IO is a really unusual thing.
>>
>>I strongly agree. Of course it would be
>>nice/necessary to have seperate nice values,
>>but setting the global one should set the
>>underlying ones (cpu, disk, ...) also.
> 
> Global one? nice is CPU in Linux, period.

Currently this is what it actually does.
But functionally, high nice value (to me at least)
means this process is low priority on the system =>
other processes get more system resources, and
the fact that this doesn't apply to IO until
now is just a defect. Now I can see some advantage
to splitting the tunables but not requiring
a new interface to turn this functionalit on.
I would like the new interface to turn it off.
I.E. I would like:

nice
     cpu
     IO

whereas you would like:

really_nice
     nice
     ionice

> ionice is io priority. I'm not
> going to change this. So Albert and you can agree as much as you want,
> unless you have some heavier arguments it's not going to help one bit.

fair enough.

Pádraig.

