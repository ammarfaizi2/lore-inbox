Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVCBKjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVCBKjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 05:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVCBKjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 05:39:15 -0500
Received: from wasp.net.au ([203.190.192.17]:3996 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S262255AbVCBKjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 05:39:11 -0500
Message-ID: <422597C3.5020207@wasp.net.au>
Date: Wed, 02 Mar 2005 14:38:59 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Engelhardt <dot@dot-matrix.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: freezes with reiser4 in a raid1 with 2.6.11-rc5-mm1
References: <1109758204.422590fca7872@domainfactory-webmail.de>
In-Reply-To: <1109758204.422590fca7872@domainfactory-webmail.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Engelhardt wrote:
> 
> I activated the raid (/dev/md0), then mounted it, and after
> that i was starting nfs. I was able to mount the share
> on my desktop, creating direcrotys was no problem, but
> as soon as i was copying a file to the share, the server
> freezed.
> Creating files localy (while loged in via ssh) is leading
> to the process is staying in state D.
> Sometimes, when i start nfsd, the system reboots immediately,
> sometimes not.
> At the momment, most of the processes are in state D, reboot
> does not work, and i am not at home, so i am unable to reboot
> the machine manualy.

Neat trick which I only discovered in desparation last week when battling a RAID lockup on the 
-rc4-mm1 kernel on a remote box.

I was also having hard lockup issues, but reseating all my PCI cards appear to have rectified that one.

As root. echo b > /proc/sysrq-trigger

Of course only if you have alt-sysrq built in.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
