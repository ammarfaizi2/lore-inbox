Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314621AbSEHRA2>; Wed, 8 May 2002 13:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314755AbSEHRA1>; Wed, 8 May 2002 13:00:27 -0400
Received: from mta23-acc.tin.it ([212.216.176.76]:27333 "EHLO fep23-svc.tin.it")
	by vger.kernel.org with ESMTP id <S314621AbSEHRAZ> convert rfc822-to-8bit;
	Wed, 8 May 2002 13:00:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Johnny Mnemonic <johnny@themnemonic.org>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: bug in tmpfs
Date: Wed, 8 May 2002 19:03:29 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020508170024.RTDY6993.fep23-svc.tin.it@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----------  Forwarded Message  ----------

Subject: Re: bug in tmpfs
Date: 08 May 2002 09:17:21 +0200
From: Christoph Rohland <cr@sap.com>
To: Johnny Mnemonic <johnny@themnemonic.org>

> I've noticed the following wrong behaviour on tmpfs:
>
> (running kernel 2.4.18)
>
> [johnny@revenge johnny]$ cd /mnt/shm
> [johnny@revenge shm]$ rm -rf W
> [johnny@revenge shm]$ mkdir W
> [johnny@revenge shm]$ cd W
> [johnny@revenge W]$ touch MYFILE
> [johnny@revenge W]$ ln -s X Y
> [johnny@revenge W]$ ls -l
> total 0
> -rw-rw-r--    1 johnny   johnny          0 May  7 19:37 MYFILE
> -rw-rw-r--    1 johnny   johnny          0 May  7 19:37 MYFILE
> lrwxrwxrwx    1 johnny   johnny          1 May  7 19:37 Y -> X
> [johnny@revenge W]$ ls -l
> total 0
> -rw-rw-r--    1 johnny   johnny          0 May  7 19:37 MYFILE
> lrwxrwxrwx    1 johnny   johnny          1 May  7 19:37 Y -> X
> [johnny@revenge W]$
>
> This bug is reproducible in most ways, when you create a
> non-existent symlink, the first ls will always show up two "MYFILE",
> while the second and further one won't.

This is probably a misbehaviour of the general cfs layer on which the
tmpfs directory handling relies. Further on my time nowaday is totally
sucked up by my job. So I can't look into this myself.

Please report this bug to the Linux Kernel Mailing list.

Greetings
                Christoph

-------------------------------------------------------

Anyone would like to track this bug before 2.4.19 release?

Regards

-- 
Johnny
