Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVKKLwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVKKLwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 06:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVKKLwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 06:52:21 -0500
Received: from relay4.usu.ru ([194.226.235.39]:1754 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750724AbVKKLwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 06:52:20 -0500
Message-ID: <43748583.9050105@ums.usu.ru>
Date: Fri, 11 Nov 2005 16:50:27 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu, sfrench@us.ibm.com,
       castet.matthieu@free.fr, greg@kroah.com, vojtech@suse.cz,
       dtor_core@ameritech.net
Subject: Re: 2.6.14-mm1
References: <20051106182447.5f571a46.akpm@osdl.org>	<436F7DAA.8070803@ums.usu.ru>	<20051107115210.33e4f0bf.akpm@osdl.org>	<200511072021.jA7KL4kA030734@turing-police.cc.vt.edu> <20051107124647.212a670d.akpm@osdl.org> <4374651A.7000605@ums.usu.ru> <437472DA.4090001@linuxfromscratch.org>
In-Reply-To: <437472DA.4090001@linuxfromscratch.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.32.0.58; VDF: 6.32.0.170; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> I wrote:
>
>> Note that unlike with the previous kernels, the huge traffic is not 
>> reported on the ppp0 interface.
>
>
>
> I was wrong. There are two failure modes, one with huge traffic and 
> one without. Attached is a sample tcpdump of the failure mode with the 
> huge traffic. If you know how to capture data going through the serial 
> port, I will do this also.

I was wrong again. There is only one failure mode, with apparent huge 
traffic, but that traffic doesn't appear immediately after the keyboard 
bug. One more note: if a key is pressed when the bug manifests itself, 
it autorepeats in X indefinitely.

An archive that contains both the tcpdump and pppdump of the bug is 
available at:

http://ums.usu.ru/~patrakov/bad-dump.tar.bz2

Taken with commands:

pppd call motiv record ppp0.pppdump nodetach
tcpdump -i ppp0 -s 0 -w ppp0.tcpdump

Then irrelevant tails that consist of repeating packets were cut off by 
hand.

-- 
Alexander E. Patrakov
