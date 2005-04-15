Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVDOHVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVDOHVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 03:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVDOHVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 03:21:55 -0400
Received: from smtp2.netcologne.de ([194.8.194.218]:46824 "EHLO
	smtp2.netcologne.de") by vger.kernel.org with ESMTP id S261752AbVDOHVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 03:21:53 -0400
Message-ID: <425F6B87.5070805@interia.pl>
Date: Fri, 15 Apr 2005 09:21:43 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: poor SATA performance under 2.6.11 (with < 2.6.11 is OK)?
References: <425E9902.8000804@interia.pl> <20050414165535.GA15440@irc.pl> <425EE9CF.4030202@interia.pl> <20050414230317.GA12156@irc.pl>
In-Reply-To: <20050414230317.GA12156@irc.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:

>>>See: http://home-tj.org/m15w/
>>
>>...but this link just doesn't explain why performance is sooo bad with 
>>2.6.11.x kernels (Timing buffered disk reads at 10-20 MB/sec), and is 
>>just OK with older 2.6 kernels (Timing buffered disk reads even at about 
>>100 MB/sec with 2.6.8.1).
>>
>>any clue?
> 
> 
>  The sata_sil blacklist grown over time. Older version didn't mark your
> drive as bad. Check sata_sil history at
> http://www.linuxhq.com/kernel/file/drivers/scsi/sata_sil.c ,
> you may find exact time when your drive got blacklisted.

OK thanks, I'll look for that.

What is this blacklisting really (besides that it gives bad performance 
for me)?

Does it mean that if I use a kernel which performs well on this hardware 
(i.e. 2.6.8.1, does not seem to have this blacklisting enabled yet) I 
risk data corruption?

And on a kernel in which my hardware is blacklisted, and therefore which 
performs poorly, I don't risk data corruption (at least when it comes to 
transferring data between the drive and the SATA controller)?


Tomek
