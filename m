Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423375AbWBBIXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423375AbWBBIXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423377AbWBBIXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:23:19 -0500
Received: from ns2.suse.de ([195.135.220.15]:59614 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423375AbWBBIXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:23:18 -0500
From: Neil Brown <neilb@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Date: Thu, 2 Feb 2006 19:23:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17377.49516.989172.414525@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4 i386 atomic operations broken on SMP (in modules
 at least)
In-Reply-To: message from J.A. Magallon on Thursday February 2
References: <17377.24090.486443.865483@cse.unsw.edu.au>
	<20060202023550.46f06ee1@werewolf.auna.net>
	<17377.25947.81994.747575@cse.unsw.edu.au>
	<20060202091514.5e9f356e@werewolf.auna.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 2, jamagallon@able.es wrote:
> On Thu, 2 Feb 2006 12:50:19 +1100, Neil Brown <neilb@suse.de> wrote:
> 
> > On Thursday February 2, jamagallon@able.es wrote:
> > > On Thu, 2 Feb 2006 12:19:22 +1100, Neil Brown <neilb@suse.de> wrote:
> > > 
> > > > 
> > > > I've been testing md/raid in 2.6.16-rc1-mm4 on a dual Xeon with most
> > > > of the md personalities compiled as modules, and weird stuff if
> > > > happening.
> > > > 
> > > > In particular I'm getting lots of 
> > > > 
> > > >     BUG: atomic counter underflow at:
> > > > 
> > > > reports in raid10 and raid5, which are modules.
> > > > 
> > > >
> > > 
> > > I also run this kernel (plus a couple patches) on a SATA raid5 setup, and
> > > had no problems. People throws and gets files via SMB/AFP, mainly.
> > > 
> > > My box is dual PIII@933.
> > 
> > Is 'raid5' a module, or is it compiled in?
> > 
> 
> nada:/usr/src/linux# grep _MD_ .config
> CONFIG_MD_LINEAR=y
> CONFIG_MD_RAID0=y
> CONFIG_MD_RAID1=y
> CONFIG_MD_RAID10=y
> CONFIG_MD_RAID5=y

I see it's not a module.
That points pretty strongly to the module loading code then I guess.

Thanks,
NeilBrown
