Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTKJTzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTKJTzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:55:44 -0500
Received: from wiggis.ethz.ch ([129.132.86.197]:8629 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S263176AbTKJTzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:55:42 -0500
From: Thom Borton <borton@phys.ethz.ch>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: PCMCIA CD-ROM does not work
Date: Mon, 10 Nov 2003 20:55:38 +0100
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.44.0310131027060.3684-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310131027060.3684-100000@logos.cnet>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311102055.38852.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Marcelo

The problem seems to be one of those self-healing things that occur 
once in a while. I just tried 2.4.23-pre9 and the CD-ROM drive works 
again. Plug in the PCMCIA card, double beep, mount disk, read it, 
unmount, unplug card. A mysterious syslog message about a "bad 
special flag" that had always shown up has also disappeared.

Seems like someone has worked on it :-)

Anyways, thanks to all kernel developers,

Thom

P.S.: For those interested, the problem was about a PCMCIA CD-ROM on a 
Sony Vaio PCG-Z600NE that stopped working with 2.4.21/22. 

On Monday 13 October 2003 14:35, you wrote:
> On Sat, 11 Oct 2003, Thom Borton wrote:
> > Hey
> >
> > If have now compiled a series of kernels starting from 2.4.18 up
> > to 2.4.22. The drive stops working with 2.4.21. That is indeed
> > where the "drivers/ide/legacy" directory was introduced.
> >
> > What do you mean by binary search? What's a "pre"?
>
> Try 2.4.21-pre1, 2.4.21-pre2, 2.4.21-pre3 etc. to find exactly
> where it stopped working. You can find the patches against 2.4.20
> at
>
> ftp.kernel.org/pub/linux/kernel/v2.4/testing/old/
>
> > Further: In 2.4.22 I get an Oops and the whole system stops when
> > I unplug the pcmcia card -> hard reset.
> >
> > It says:
> >
> > ///////////
> > remove_proc_entry: hde/identify busy, count=1
> > remove_proc_entry: ide2/hde busy, count=1
> > Unable to handle kernel paging request at virtual address
> > 655f6373 printing eip:
> > c011c5b5
> > *pde = 00000000
> > Oops: 0002
> > CPU:     0
> > .......
> > .......
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> > In interrupt handler - not syncing
> > ///////////
> >
> > Sound's scarry, but doesnt tell me a lot, except that I have to
> > reboot the system.
>
> Can you please post the full kernel panic message?

-- 
Thom Borton
Switzerland

