Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130309AbRARTwG>; Thu, 18 Jan 2001 14:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRARTv4>; Thu, 18 Jan 2001 14:51:56 -0500
Received: from palrel3.hp.com ([156.153.255.226]:35599 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S131202AbRARTvp>;
	Thu, 18 Jan 2001 14:51:45 -0500
Message-ID: <3A67494D.5D09DF2B@cup.hp.com>
Date: Thu, 18 Jan 2001 11:51:41 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.GSO.4.10.10101181938310.25170-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> device-to-device is not the same as disk-to-disk. A better example would
> be a streaming file server. Slowly the pci bus becomes a bottleneck, why
> would you want to move the data twice over the pci bus if once is enough
> and the data very likely not needed afterwards? Sure you can use a more
> expensive 64bit/60MHz bus, but why should you if the 32bit/30MHz bus is
> theoretically fast enough for your application?

theoretically fast enough for the application would imply the dual
transfers across the bus would fit :)

also, if a system was doing something with that much throughput, i
suspect it would not only be designed with 64/66 busses (or better), but
also have things on several different busses. that makes device to
device life more of a challenge.

rick jones

-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
