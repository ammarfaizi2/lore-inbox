Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSDWR41>; Tue, 23 Apr 2002 13:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315281AbSDWR40>; Tue, 23 Apr 2002 13:56:26 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:59408 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315278AbSDWR4Z>; Tue, 23 Apr 2002 13:56:25 -0400
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
From: Miles Lane <miles@megapathdsl.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1019583551.1392.5.camel@turbulence.megapathdsl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 23 Apr 2002 10:54:57 -0700
Message-Id: <1019584497.1393.8.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-23 at 10:39, Miles Lane wrote:
> On Tue, 2002-04-23 at 01:00, Martin Dalecki wrote:
> > Miles Lane wrote:
> > > I should probably add the /proc/ksyms snapshotting stuff to 
> > > get the module information for you as well.  I hope this 
> > > current batch of info helps, for starters.
> > > 
> > > ksymoops 2.4.4 on i686 2.4.7-10.  Options used
> > >      -v /usr/src/linux/vmlinux (specified)
> > >      -K (specified)
> > >      -L (specified)
> > >      -o /lib/modules/2.5.9/ (specified)
> > >      -m /boot/System.map-2.5.9 (specified)
> > 
> > 
> > Looks like the oops came from module code.
> > Which modules did you use: ide-flappy and ide-scsi are still
> > in need of the same medication ide-cd got.
> 
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_SCSI=m
> CONFIG_BLK_DEV_SD=m
> CONFIG_BLK_DEV_SR=m
> CONFIG_CHR_DEV_SG=m

Hmm.  You probably need this, too.  Sorry for not sending this
in the first reply.

CONFIG_IDE=y

#
# ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_IDEDMA_AUTO=y


