Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJTbJ>; Wed, 10 Jan 2001 14:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbRAJTbA>; Wed, 10 Jan 2001 14:31:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6405 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129406AbRAJTan>; Wed, 10 Jan 2001 14:30:43 -0500
Subject: Re: Subtle MM bug
To: ak@suse.de (Andi Kleen)
Date: Wed, 10 Jan 2001 19:31:52 +0000 (GMT)
Cc: trond.myklebust@fys.uio.no (Trond Myklebust),
        phillips@innominate.de (Daniel Phillips),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010110183256.A28025@gruyere.muc.suse.de> from "Andi Kleen" at Jan 10, 2001 06:32:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GQyR-0000mh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> struct ucred is also needed to get LinuxThreads POSIX compliant (sharing
> credentials between threads, but still keeping system calls atomic in
> relation to credential changes) 

That is extremely undesirable behaviour. setuid() changes for pthreads crud
should be done by the library emulation layer. Many people have very real
and very good reasons for running multiple parallel ids. Just try writing
a threaded ftp daemon (non anonymous) without that, or an nfs server

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
