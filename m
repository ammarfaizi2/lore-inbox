Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWJMR77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWJMR77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWJMR77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:59:59 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:53771 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1751768AbWJMR75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:59:57 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 6/10] VIOC: New Network Device Driver
Date: Fri, 13 Oct 2006 10:51:07 -0700
User-Agent: KMail/1.5.1
References: <200610051105.51259.misha@fabric7.com> <200610091109.39793.misha@fabric7.com> <20061009120324.56bac955@freekitty>
In-Reply-To: <20061009120324.56bac955@freekitty>
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <netdev@vger.kernel.org>,
       "Sriram Chidambaram" <schidambaram@fabric7.com>,
       Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610131051.07557.misha@fabric7.com>
X-OriginalArrivalTime: 13 Oct 2006 17:59:57.0052 (UTC) FILETIME=[64B17BC0:01C6EEF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 October 2006 12:03 pm, Stephen Hemminger wrote:
> On Mon, 9 Oct 2006 11:09:39 -0700
>
> Misha Tomushev <misha@fabric7.com> wrote:
> > On Sunday 08 October 2006 12:27 am, Pavel Machek wrote:
> > > Hi!
> > >
> > > > +	ecmd->phy_address = 0;	/* !!! Stole from e1000 */
> > > > +	ecmd->speed = 3;	/* !!! Stole from e1000 */
> > >
> > > Eh?
> >
> > You are right. Will fix.
> >
> > > > +static void vnic_get_regs(struct net_device *netdev,
> > > > +			  struct ethtool_regs *regs, void *p)
> > > > +{
> > > > +	struct vnic_device *vnicdev = netdev->priv;
> > > > +	struct vioc_device *viocdev = vnicdev->viocdev;

> > >
> > > This looks ugly. What interface is that?

> Please just dump binary like other drivers.  The code for ethtool allows
> per device decode. Move the decode to there.
>
> Yes, ethtool source does need a more generic register description language.

Signed-off-by: Misha Tomushev  <misha@fabric7.com>

Please pull the patch from ftp://ftp.fabric7.com/VIOC/vioc_patch.2006-10-12-17-40


-- 
Misha Tomushev
misha@fabric7.com


