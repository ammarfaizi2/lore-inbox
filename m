Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTLWStL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTLWStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:49:10 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:23929 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S262303AbTLWStD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:49:03 -0500
Message-ID: <3FE88E18.7080507@samwel.tk>
Date: Tue, 23 Dec 2003 19:48:56 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Attempt at laptop-mode for 2.6.0
References: <3FE85E11.5020602@samwel.tk> <20031223163810.GB23184@suse.de>
In-Reply-To: <20031223163810.GB23184@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>>Even though I don't own a laptop, I find it very irritating that my hard
>>drive is active so much. Wanting to fix this, I found the Jens Axboe's
>>"laptop-mode" patch. Unfortunately it hadn't been ported to Linux
>>2.6.0 yet, and I'm using that as my primary kernel now. I gave porting 
>>it a shot, and here is the result. I'm running it right now, and my hard 
>>drive has been spun down for the complete time I have been writing this 
>>message. Still, I'm not sure whether it really works as advertised. :) 
>>The reason is that my PC is also a mail server for my personal e-mail, 
>>and I receive e-mails more than once every 10 minutes (fscking spam!). 
>>Still, the tests that I've done seem to indicate that it works.
> 
> Thanks for getting this started. I'm not particularly fond of the
> behaviourial changes you made, I guess most are due to it being
> incomplete?

Is it only the block dirtyings that you're missing, or is there more? I 
might have used an old 2.4 patch as reference -- what was the latest 
version again?

> The block dirtying is the most interesting aspect of the dump
> functionality, reporting WRITEs don't give you the info you need
> to fix your setup.

OK, that depends on your point of view. At this point it weren't the 
WRITEs that were interesting to me, it were the READs. The WRITEs just 
came as a bonus. The reason: what bugged me during development were the 
programs that read new data from disk, and I wanted to find out what to 
turn off in order to keep the disk from spinning up all the time. And 
when the disk DID spin up, I wanted to know if it was my fault or if it 
was some daemon messing up my tests again. This is due to my not 
actually working on a laptop but on a home server machine. :) I guess 
that when you're going for disk-spindowns of longer than 10 minutes 
(which is what the block dirtying dumps are for, presumably?) dirtyings 
start to become interesting. I'll see if I can port that bit as well, 
shouldn't be that much work.

Bart

