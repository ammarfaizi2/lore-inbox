Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTD2SyN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 14:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTD2SyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 14:54:13 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:35525 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S262131AbTD2SyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 14:54:12 -0400
Message-ID: <3EAECD2B.3080509@cox.net>
Date: Tue, 29 Apr 2003 14:06:19 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Question regarding inactive memory
References: <3EAEC5BC.3070008@cox.net> <Pine.LNX.4.53.0304291444240.5847@chaos>
In-Reply-To: <Pine.LNX.4.53.0304291444240.5847@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Tue, 29 Apr 2003, David van Hoose wrote:
> 
> 
>>This may be a bit of a newbie'ish question, and maybe a bit off-topic,
>>but is there any way for me to remove inactive memory, either explicitly
>>or implicitly? I have 512MB of PC2700 SDRAM, but my system is constantly
>>eating into the swap I have on my system since I have usually about
>>140-300MB of inactive (and dirty) RAM and usually about only 250MB in
>>active memory. Is there a way for me to correct this bad memory usage
>>without having to reboot? If patching the kernel would be a possible
>>route to venture to, I'm game.
>>
>>Any suggestions or comments are welcome.
> 
> Assuming you are not using a development kernel, the memory
> manager will try to use most all available RAM. This is
> normal. During most usage, many of the daemons get swapped out,
> and unless they are awakened, they don't get swapped back in.
> This is normal because one does not want to waste the CPU
> cycles necessary to swap back in RAM data that will not be
> used.
> 
> The purpose of using most all available RAM is to save CPU
> cycles and make the machine responsive. If you have a program
> that needs RAM, it is grabbed from those buffers you see if
> you do `cat /proc/meminfo`. The idea is to nat waste any
> RAM.
> 
> If you want to just write the stuff on your swap device(s)
> back to RAM, to see that it "really works", just execute,
> `swapoff -a` as root. You can then execute `swapon -a` and
> you are back to "normal".
> 
> The 'dirty' buffers are kept around, even after being written
> to disk, so they don't have to be re-read the next time you
> execute `ls` or run a program.

I am currently using kernel 2.4.21-rc1.
Problem I am having is that my swap is used only after all of my 
physical ram is used. My system then starts to run a lot slower. 
Especially processes that allocate lots of memory. If the kernel knows 
that memory is inactive, why doesn't it swap it to disk so that memory 
doesn't have to be shuffled around when a new process needs memory? It 
would also make me happy to be able to swap dirty memory to disk.

Thanks,
David

