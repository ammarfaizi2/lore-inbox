Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSKETmZ>; Tue, 5 Nov 2002 14:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265170AbSKETmZ>; Tue, 5 Nov 2002 14:42:25 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:53909 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265169AbSKETmY>; Tue, 5 Nov 2002 14:42:24 -0500
Subject: Re: [lkcd-devel] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Werner Almesberger <wa@almesberger.net>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <20021105161902.I1408@almesberger.net>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
	<3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net>
	<20021105171230.A11443@in.ibm.com> <20021105150048.H1408@almesberger.net>
	<1036521360.5012.116.camel@irongate.swansea.linux.org.uk> 
	<20021105161902.I1408@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 20:10:46 +0000
Message-Id: <1036527046.6750.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 19:19, Werner Almesberger wrote:
> kexec needs:
>  - a system call to set it up

Device, file, insmod...

>  - a way to silence devices (difference to dumper: kexec normally
>    operates under an intact system, so it's more similar to, say,
>    swsusp. But I expect that cleaning up device power management
>    would also clear the path for more reliable dumpers.)

So you need to register with the power management as the last thing to
be suspended and do a suspend before kexec.

> So not merging it is mainly inconvenient to use, adds the system
> call allocation as a continuous annoyance, and makes it a little
> harder to work on the related infrastructure. But then, despite
> being somewhat obscure, bootimg and kexec have been in use for
> years, the design is about as lean as it can get, and it's cool.
> What more could you ask for ? :-)

I'm mostly worried about how to make these things fit the least
intrusively into the kernel.

