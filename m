Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRA0MvI>; Sat, 27 Jan 2001 07:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130309AbRA0Mus>; Sat, 27 Jan 2001 07:50:48 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:36277 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S130154AbRA0Mum>;
	Sat, 27 Jan 2001 07:50:42 -0500
Date: Sat, 27 Jan 2001 07:49:35 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <200101271005.f0RA5DX04357@moisil.dev.hydraweb.com>
Message-ID: <Pine.GSO.4.30.0101270747210.24088-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Jan 2001, Ion Badulescu wrote:

>
> 750MHz PIII, Adaptec Starfire NIC, driver modified to use hardware sg+csum
> (both Tx/Rx), and Intel i82559 (eepro100), no hardware csum support,
> vanilla driver.
>
> The box has 512MB of RAM, and I'm using a 100MB file, so it's entirely cached.
>
> starfire:
> 2.4.1-pre10+zerocopy, using sendfile():		 9.6% CPU
> 2.4.1-pre10+zerocopy, using read()/write():	18.3%-29.6% CPU		* why so much variance?
>

What are your throughput numbers?

Could you also, please, test using:

http://www.cyberus.ca/~hadi/ttcp-sf.tar.gz

post both sender and receiver data. Repeat each test about
5 times.

cheers,
jamal


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
