Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbUAZKnm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 05:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUAZKnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 05:43:42 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:60544 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265173AbUAZKnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 05:43:39 -0500
Message-ID: <4014EF53.7060504@samwel.tk>
Date: Mon, 26 Jan 2004 11:43:31 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lutz Vieweg <lkv@isg.de>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       adilger@clusterfs.com
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle
 disks? (to allow spin-downs)
References: <40140B0A.90707@isg.de> <1075058769.1756.8.camel@teapot.felipe-alfaro.com> <4014E8E6.7050007@isg.de>
In-Reply-To: <4014E8E6.7050007@isg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lutz Vieweg wrote:
> It's not a laptop, but a server with an ordinary 3.5" harddisk I'm 
> speaking about,
> my goal is not saving power, but spinning down a harddisk that does not 
> need to
> spin up the whole day long.
> 
> What I'm questioning is whether there's a need to write to idle disks at 
> all -
> does anybody know why kjournald writes data even if there is nothing to 
> commit at all?

Hmmm. My 2nd HD (that I almost never use) is set to hdparm -S 4 (20 
seconds), it has an ext3 filesystem on it, and it spins down some 20 
seconds after mounting and never spins up again. I haven't had to set 
any options to make this possible. Is it possible that there may still 
be something that is dirtying blocks on that disk? (If you want to check 
this out, laptop_mode has a /proc/sys/vm/block_dump setting that makes 
the kernel log all reads, writes and block dirtyings.)

-- Bart
