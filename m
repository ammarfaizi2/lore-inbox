Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbREOVds>; Tue, 15 May 2001 17:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbREOVdl>; Tue, 15 May 2001 17:33:41 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:56583 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261573AbREOVco>; Tue, 15 May 2001 17:32:44 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105152126.XAA23684@green.mif.pg.gda.pl>
Subject: Re: LANANA: To Pending Device Number Registrants
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 15 May 2001 23:26:44 +0200 (CEST)
Cc: jlundell@pobox.com, jgarzik@mandrakesoft.com, jsimmons@transvirtual.com,
        alan@lxorguk.ukuu.org.uk (Alan Cox), neilb@cse.unsw.edu.au,
        hpa@transmeta.com, linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 15 May 2001, Jonathan Lundell wrote:
> > >
> > >Keep it informational. And NEVER EVER make it part of the design.
> > 
> > What about:
> > 
> > 1 (network domain). I have two network interfaces that I connect to 
> > two different network segments, eth0 & eth1;
> 
> So?
> 
> Informational. You can always ask what "eth0" and "eth1" are.
> 
> There's another side to this: repeatability. A setup should be
> _repeatable_.

It stops to be repetable unless you are able to define *which* interface
become eg. eth0 after boot. Think of hotplug...

> This is what we have now. Network devices are called "eth0..N", and nobody
                                                                      ^^^^^^
Not true. I did. Once :)

> is complaining about the fact that the numbering is basically random. It
> is _repeatable_ as long as you don't change your hardware setup, and the
> numbering has effectively _nothing_ to do with "location".

Consider the following situation:
- you have three ethernet adapters supported by a single driver; assume
  they are *significantly* different
- you hotplug a spare adapter, supported by the same driver
- your spare adapter become eth0 after reboot...
- you need access to a NFS server on former eth2 during boot

How would you configure the system to boot regardless the spare adapter is
plugged in or not?

> You don't say "oh, I have my network card in PCI bus #2, slot #3,
> subfunction #1, so I should do 'ifconfig netp2s3f1'". Right?

ifconfig eth-00:20:12:34:ab:cd ?

I'd prefer using MAC address here, but it is also not good as MAC need not
to be unique.

> The location of the device is _meaningless_. 

Unfortunately sometimes it is. Rare cases. I used to hit one.

> So? Same deal. You don't have eth0..N, you have disk0..N. 
> 
> What's the problem? It's _repeatable_, in that as long as you don't change
> your disks, they'll show up the same way. But the 0..N doesn't imply that
> the disks are anywhere special.

Not good comparison. You can mount filesystems on disks by UUID.
You should be independent on disk names then.

> Linux gets this _somewhat_ right. The /dev/sdxxx naming is correct (or, if
> you look at only IDE devices, /dev/hdxxx). The problem is that we don't
> have a unified namespace, so unlike eth0..N we do _not_ have a unified
> namespace for disks.

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
