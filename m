Return-Path: <linux-kernel-owner+w=401wt.eu-S1758797AbWLIWOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758797AbWLIWOr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758817AbWLIWOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:14:47 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52983 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758797AbWLIWOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:14:46 -0500
X-Originating-Ip: 74.109.98.100
Date: Sat, 9 Dec 2006 17:10:54 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] Fix numerous kcalloc() calls, convert to kzalloc().
In-Reply-To: <457B3346.2020008@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0612091710250.8007@localhost.localdomain>
References: <Pine.LNX.4.64.0612090950580.14897@localhost.localdomain>
 <457B3346.2020008@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006, Stefan Richter wrote:

> Robert P. J. Day wrote:
> >  drivers/ata/pdc_adma.c              |    4 ++--
> >  drivers/macintosh/smu.c             |    2 +-
> >  drivers/mtd/rfd_ftl.c               |    2 +-
> >  drivers/net/phy/phy_device.c        |    2 +-
> >  drivers/net/skge.c                  |    2 +-
> >  drivers/pcmcia/at91_cf.c            |    2 +-
> >  drivers/pcmcia/omap_cf.c            |    2 +-
> >  drivers/pnp/isapnp/core.c           |   22 +++++++++++-----------
> >  drivers/pnp/pnpacpi/core.c          |    6 +++---
> >  drivers/pnp/pnpacpi/rsparser.c      |   22 +++++++++++-----------
> >  drivers/pnp/pnpbios/core.c          |   14 +++++++-------
> >  drivers/pnp/pnpbios/proc.c          |    8 ++++----
> >  drivers/pnp/pnpbios/rsparser.c      |   16 ++++++++--------
> >  drivers/scsi/sym53c8xx_2/sym_hipd.c |    2 +-
> >  drivers/usb/gadget/at91_udc.c       |    2 +-
> >  drivers/usb/misc/uss720.c           |    2 +-
> >  drivers/usb/net/rndis_host.c        |    2 +-
> >  fs/ocfs2/alloc.c                    |    2 +-
> >  fs/ocfs2/cluster/heartbeat.c        |    4 ++--
> >  fs/ocfs2/cluster/nodemanager.c      |    6 +++---
> >  fs/ocfs2/cluster/tcp.c              |   10 +++++-----
> >  fs/ocfs2/dlm/dlmdomain.c            |    4 ++--
> >  fs/ocfs2/dlm/dlmlock.c              |    4 ++--
> >  fs/ocfs2/dlm/dlmmaster.c            |    2 +-
> >  fs/ocfs2/dlm/dlmrecovery.c          |    6 +++---
> >  fs/ocfs2/localalloc.c               |    2 +-
> >  fs/ocfs2/slot_map.c                 |    2 +-
> >  fs/ocfs2/suballoc.c                 |    6 +++---
> >  fs/ocfs2/super.c                    |    6 +++---
> >  fs/ocfs2/vote.c                     |    4 ++--
> >  include/linux/gameport.h            |    2 +-
> >  kernel/relay.c                      |    4 ++--
> >  net/sunrpc/svc.c                    |    2 +-
> >  sound/pci/hda/patch_realtek.c       |    4 ++--
> >  34 files changed, 91 insertions(+), 91 deletions(-)
>
> This should really be split up and submitted separately. All the subsystems
> are constantly changing. Although merging these kinds of changes manually
> after eventual conflicts, it's still manual work for the maintainers which
> would be avoided by a little bit extra work by the submitter. A maintainer
> could get a merge conflict on a 100 lines long hunk because of an 8 lines
> long hunk that got upstream on a different route.

fuck it, i give up.  drop me a note when the grown-ups are back in
charge.

rday
