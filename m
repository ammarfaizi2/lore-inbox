Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTJIVaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTJIVaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:30:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:46720 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262598AbTJIV34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:29:56 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Erik Bourget <erik@midmaine.com>, andre@linux-ide.org
Subject: Re: SiI680 oops/panic
Date: Thu, 9 Oct 2003 23:33:39 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <87oewqt8ia.fsf@loki.odinnet>
In-Reply-To: <87oewqt8ia.fsf@loki.odinnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310092333.39332.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please write down your oops and decode it using ksymoops.

thanks,
--bartlomiej

On Thursday 09 of October 2003 23:18, Erik Bourget wrote:
> (Cc to lkml in case anybody else has any intuition).
>
> Hello Andre;
>
> A while ago I spoke with you about my funky SiI680 experiences.  I have
> since decided that my Hitachi "DeathStar" 180GXP harddrives were all
> faulty, and replaced them with Western Digital..  This was bad.  On the
> other hand, the kernel /DID/ oops/panic a few times, and I finally managed
> to drive to the datacenter before somebody rebooted it.
>
> And I took a shot with my trusty digital camera.
> http://tacos.sus.mcgill.ca/~erik/oops-panic.jpg (24,457b)
> (textual bits have been re-typed below)
>
> Kernel: 2.4.21, SMP (also happened on 2.4.22, also SMP)
> (Note that the box has only one CPU, and no 'hyperthreading')
>
> Text from it:
>
> printing eip:
> 3d3d3d3d
> *pde = 00000000
> Oops: 0000
> CPU:   0
> EIP:  0010:[<3d3d3d3d>]  Not tainted
> EFLAGS: 00010046
> ...
> Process nfsd (pid: 200)
> ...
> Code: Bad EIP value.
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>
> Hardware:
>   Dell "650" 1U server, P4 2.4GHz, 512MB, 2x120-GB Hitachi 180GXP DeskStar
>   drives in RAID-1 configuration.
>
> Software: vanilla Debian woody, vanilla kernel.org kernels.
>
> Load on the drives was Constant and Extreme.  The machines serve as mail
> storage for our ISP's mail system.  The drives were running a constant
> synch process that checked a database to see which users had authenticated
> with the mail system (via POP3, IMAP, etc - such that they might have
> deleted mail) and ran rsync to an identical machine over a 1000mbit link on
> their directories. Literally -
>
> while(1) {
>          @userlist = changed_directories();
>          foreach (@userlist) {
>                  do_rsync(localhost:$_, remotehost:$_);
>          }
>          sleep(30);
> }
>
> Can you make heads or tails of this?  My first thought is that some driver
> isn't handling faulty hardware in an error-tolerant way.
>
> Thanks for your time;
>
> - Erik Bourget

