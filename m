Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVCEJ2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVCEJ2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 04:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVCEJ2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 04:28:45 -0500
Received: from wasp.net.au ([203.190.192.17]:59338 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261159AbVCEJ2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 04:28:42 -0500
Message-ID: <42297BB9.5040608@wasp.net.au>
Date: Sat, 05 Mar 2005 13:28:25 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Engelhardt <flo@dotbox.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: freezes with reiser4 in a raid1 with 2.6.11-rc5-mm1
References: <1109758204.422590fca7872@domainfactory-webmail.de>	<422597C3.5020207@wasp.net.au> <20050305100637.3aa6e1b8@discovery.hal.lan>
In-Reply-To: <20050305100637.3aa6e1b8@discovery.hal.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Engelhardt wrote:

>>Neat trick which I only discovered in desparation last week when
>>battling a RAID lockup on the -rc4-mm1 kernel on a remote box.
>>
>>I was also having hard lockup issues, but reseating all my PCI cards
>>appear to have rectified that one.
> 
> 
> Well, there are not much PCI-Cards in this server and reseating them
> didnt fix it.

Sorry, I was just pointing out what "appeared" to solve my hard-lock problems, I was not suggesting 
it as a cure for yours.

>>As root. echo b > /proc/sysrq-trigger
>>
>>Of course only if you have alt-sysrq built in.
> 
> 
> Thanks for that, i was able to reboot the machine with that trick, but
> i couldnt find anything bad in the messages file.
> 
> I made some further tests with the server:
> Deactivating the raid, and formating the hd´s (hdc and hdd) with
> reiser4, mounting them and sharing them via nfs and ftp worked great, no
> freezes, no reboots, everything perfect, even the performance.
> But as soon, as i activated the raid, the server freezed, or rebooted.
> 

A complete hard lock appears to be very rare these days with kernel bugs. It may be tickling a 
hardware bug somewhere. My machine was only hard-locking when I was writing to the array. A complete 
lock-up or reboot really does sound more hardware like. Have you tried running something like memtest86?
I found after a couple of hours of memtest86 my box would lock solid, which eliminated the linux 
kernel from the equation completely.

I'm running ext3 on all my machines, so I can't help with reiser at all.
I'm running a largish raid5 on 2.6.10-bk10 and a fairly large raid6 on 2.6.11-rc5-bk3. I had 
problems with raid6 on 2.6.11-rc4-mm1 causing raid subsystem lockups, but nothing that precluded me 
from rebooting with the sysrq-trigger.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
