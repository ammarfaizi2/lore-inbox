Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbTBQRXJ>; Mon, 17 Feb 2003 12:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbTBQRXJ>; Mon, 17 Feb 2003 12:23:09 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:52509 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267198AbTBQRXI>;
	Mon, 17 Feb 2003 12:23:08 -0500
Message-ID: <3E511CC5.5000700@acm.org>
Date: Mon, 17 Feb 2003 11:32:53 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Corey Minyard <cminyard@mvista.com>,
       Werner Almesberger <wa@almesberger.net>,
       Zwane Mwaikambo <zwane@holomorphy.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org>	<3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org>	<3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net>	<3E4CFB11.1080209@mvista.com> <20030214151001.F2092@almesberger.net>	<3E4D3419.1070207@mvista.com>	<Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com>	<20030214164436.H2092@almesberger.net> <3E4D4ADF.3070109@mvista.com>	<m17kc26pxs.fsf@frodo.biederman.org> <3E4FBAD0.4040808@acm.org>	<m1y94f6gnp.fsf@frodo.biederman.org> <3E506460.3010400@acm.org> <m1wujz2x4y.fsf@frodo.biederman.org>
In-Reply-To: <m1wujz2x4y.fsf@frodo.biederman.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

So the semantics of the shutdown method is: "You are being called at 
reboot or halt time, no other processes are running or will ever run, 
quiesce the device, but do nothing else".  Then obviously, it's exactly 
what we need, if you can get the device driver writers to implement it.

It would be very nice to have documentation on this (and the rest of the 
driver model, too).  The docs in the kernel don't give a big picture.  
In fact, just reading the docs give you no idea what a driver model is.  
Does some other source of documentation exist?

device_shutdown() claims a semaphore for some reason, though.  I suspect 
it's not necessary.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+URzCIXnXXONXERcRAhmgAKCIan40sZy389m9FS/ESkH96v3efACgrwx5
hsU4LWh+FigmWx9RlejSix8=
=AMdY
-----END PGP SIGNATURE-----


