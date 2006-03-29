Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWC2JNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWC2JNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWC2JNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:13:25 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:27334 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1750801AbWC2JNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:13:24 -0500
Message-ID: <442A4FAA.4010505@openvz.org>
Date: Wed, 29 Mar 2006 13:13:14 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: devel@openvz.org
CC: Kir Kolyshkin <kir@sacred.ru>, linux-kernel@vger.kernel.org,
       sam@vilain.net, Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	<1143228339.19152.91.camel@localhost.localdomain>	<4428BB5C.3060803@tmr.com>  <4428DB76.9040102@openvz.org>	<1143583179.6325.10.camel@localhost.localdomain>	<4429B789.4030209@sacred.ru> <1143588501.6325.75.camel@localhost.localdomain>
In-Reply-To: <1143588501.6325.75.camel@localhost.localdomain>
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Do-Not-Rej: Toldya
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

>> Why do you think it can not be measured? It either can be, or it is too 
>> low to be measured reliably (a fraction of a per cent or so).
> 
> Well, for instance the fair CPU scheduling overhead is so tiny it may as
> well not be there in the VServer patch.  It's just a per-vserver TBF
> that feeds back into the priority (and hence timeslice length) of the
> process.  ie, you get "CPU tokens" which deplete as processes in your
> vserver run and you either get a boost or a penalty depending on the
> level of the tokens in the bucket.  This doesn't provide guarantees, but
> works well for many typical workloads.
I wonder what is the value of it if it doesn't do guarantees or QoS?
In our experiments with it we failed to observe any fairness. So I 
suppose the only goal of this is too make sure that maliscuios user want 
consume all the CPU power, right?

> How does your fair scheduler work?  Do you just keep a runqueue for each
> vps?
we keep num_online_cpus runqueues per VPS.
Fairs scheduler is some kind of SFQ like algorithm which selects VPS to 
be scheduled, than standart linux scheduler selects a process in a VPS 
runqueues to run.

> To be honest, I've never needed to determine whether its overhead is 1%
> or 0.01%, it would just be a meaningless benchmark anyway :-).  I know
> it's "good enough for me".
Sure! We feel the same, but people like numbers :)

Thanks,
Kirill
