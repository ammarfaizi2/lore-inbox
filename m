Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUGEPMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUGEPMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 11:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUGEPMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 11:12:51 -0400
Received: from burro.logi-track.com ([213.239.193.212]:45968 "EHLO
	mail.logi-track.com") by vger.kernel.org with ESMTP id S266136AbUGEPMr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 11:12:47 -0400
Date: Mon, 5 Jul 2004 17:12:25 +0200
From: Markus Schaber <schabios@logi-track.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at drivers/usb/storage/usb.c:848
Message-Id: <20040705171225.7767408b@kingfisher.intern.logi-track.com>
In-Reply-To: <20040702224927.GB7969@kroah.com>
References: <20040701121836.07db4217@kingfisher.intern.logi-track.com>
	<20040702224927.GB7969@kroah.com>
Organization: logi-track ag, =?ISO-8859-15?Q?z=FCrich?=
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg,

On Fri, 2 Jul 2004 15:49:27 -0700
Greg KH <greg@kroah.com> wrote:

> > Running Kernel 2.6.4-mm2 (We use an mm2 kernel because of problems
> > with highmem and cryto-loop playing together which seemed to be
> > solved in mm2) and dd'ing from a IDE disk in an external USB case,
> > the following just happened (from /var/log/syslog):
> 
> 2.6.4-mm2 is quite an old kernel.  Care to get a newer one to see if
> this is still an issue or not?

It's quite some effort to update those specific machines, but we planned
to update to 2.6.7 until we heared that there are some problems with
this version (especially, a co-worker of mine trying 2.6.7-mm1 on a
similar hardware and using both crypto-loop and highmem has had random
crashes, and some apps (including sun jdk 1.4) segfaulting on startup.).

Now we plan to update to some 2.6.6 version. Is dm-crypt considered
stable enough to give it a test shot? This way, we could get rid of
crypto-loop and thus avoid having to try the mm patches.


Thanks,
Markus

-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schabios@logi-track.com | www.logi-track.com
