Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbRAJTd3>; Wed, 10 Jan 2001 14:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131425AbRAJTdT>; Wed, 10 Jan 2001 14:33:19 -0500
Received: from Cantor.suse.de ([194.112.123.193]:21252 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129778AbRAJTdK>;
	Wed, 10 Jan 2001 14:33:10 -0500
Date: Wed, 10 Jan 2001 20:33:07 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
        Daniel Phillips <phillips@innominate.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010110203307.A5106@gruyere.muc.suse.de>
In-Reply-To: <20010110183256.A28025@gruyere.muc.suse.de> <E14GQyR-0000mh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14GQyR-0000mh-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 10, 2001 at 07:31:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 07:31:52PM +0000, Alan Cox wrote:
> > struct ucred is also needed to get LinuxThreads POSIX compliant (sharing
> > credentials between threads, but still keeping system calls atomic in
> > relation to credential changes) 
> 
> That is extremely undesirable behaviour. setuid() changes for pthreads crud
> should be done by the library emulation layer. Many people have very real
> and very good reasons for running multiple parallel ids. Just try writing
> a threaded ftp daemon (non anonymous) without that, or an nfs server

Of course not by default, it would be a new clone flag (with default to on in
linuxthreads though, to not cause security holes in ported programs like today) 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
