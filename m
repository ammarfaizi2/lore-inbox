Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317504AbSGJIlT>; Wed, 10 Jul 2002 04:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317505AbSGJIlS>; Wed, 10 Jul 2002 04:41:18 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.25]:36898 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S317504AbSGJIlR>; Wed, 10 Jul 2002 04:41:17 -0400
Message-ID: <3D2BF3CC.3040409@users.sf.net>
Date: Wed, 10 Jul 2002 10:43:56 +0200
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Terrible VM in 2.4.11+?
References: <20020709001137.A1745@mail.muni.cz> <1026167822.16937.5.camel@UberGeek> <20020709005025.B1745@mail.muni.cz> <20020708225816.GA1948@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

> Seriously, if you have that kind of problems, take the -aa kernel and use it.
> I use it regularly and it behaves as one would expect, and fast.
> And please, report your results...

I run a 2 cpu server with 16 disks and around 5 megabytes of writes a 
second. With plain 2.4.18 (using the feral.com qlogic driver) and 2GB 
ram, this seemed okay. Upgrading to 4GB ram slowed the system down, and 
normal shell commands became quite unresponsive with 4GB.

So we built a second server, with 2.4.19-pre9-aa2 using the qlogic 
driver in the kernel. That driver needs patching, as it will otherwise 
get stuck in a 'no handle slots' condition. Used a patch that I posted 
to linux-scsi a while ago.

This combination works great so far. In the meantime, the 2.4.18 box has 
been left running, but the load shoots up to 75 sometimes with no 
apparent reason (the -aa2 box stays below a load of 3).

Once the 2.4.18 box was really wedged: load at 70, server process stuck. 
I logged in and the system was very responsive, but in reponse to a 
reboot the system just sat there.

So we're going with 2.4.19-pre9-aa2 for now. I don't yet understand the 
-aa series, for example how 2.4.19-rc1-aa1 would relate to 
2.4.19-pre9-aa2, so I'm a bit wary of just upgrading in the -aa series 
right now.


Thomas


