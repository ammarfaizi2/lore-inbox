Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132970AbRAJTkT>; Wed, 10 Jan 2001 14:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132937AbRAJTkJ>; Wed, 10 Jan 2001 14:40:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14341 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131958AbRAJTj7>; Wed, 10 Jan 2001 14:39:59 -0500
Subject: Re: Subtle MM bug
To: ak@suse.de (Andi Kleen)
Date: Wed, 10 Jan 2001 19:40:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        trond.myklebust@fys.uio.no (Trond Myklebust),
        phillips@innominate.de (Daniel Phillips),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010110203307.A5106@gruyere.muc.suse.de> from "Andi Kleen" at Jan 10, 2001 08:33:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GR76-0000nv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course not by default, it would be a new clone flag (with default to on in
> linuxthreads though, to not cause security holes in ported programs like today) 

I've seen exactly nil cases where there are any security holes in apps caused
by that pthreads api non adherance. There are also far too many overheads
imposed by implementing something in kernel space that is nearly useless,
not needed for any application 99.9999% of users (possibly 100%) have and can
be done just as well in the pthreads library glue - where it will only be
a penalty to pthread using apps.

Making everyone suffer for a bad standard corner case is bad. Especially when
the 'security hole' is pure FUD


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
