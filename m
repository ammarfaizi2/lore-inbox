Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUIHSd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUIHSd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269299AbUIHSd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:33:27 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56250 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269296AbUIHSdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:33:01 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: multi-domain PCI and sysfs
Date: Wed, 8 Sep 2004 11:32:28 -0700
User-Agent: KMail/1.7
Cc: jonsmirl@gmail.com, willy@debian.org, linux-kernel@vger.kernel.org
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409080902.14640.jbarnes@engr.sgi.com> <20040908112027.545a6b2e.davem@davemloft.net>
In-Reply-To: <20040908112027.545a6b2e.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409081132.29008.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 8, 2004 11:20 am, David S. Miller wrote:
> On Wed, 8 Sep 2004 09:02:14 -0700
>
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > > Where is the PCI segment base address stored in the PCI driver
> > > structures? I'm still having trouble with the fact that the PCI driver
> > > does not have a clear structure representing a PCI segment.  Shouldn't
> > > there be a structure corresponding to a segment?
> >
> > That would be nice, maybe an extra resource or something?  I haven't
> > looked at the sparc code, but it probably deals with this (sn2 has
> > platform specific functions to get the base address for a bus).
>
> We store them directly in pci_resource_*(pdev,BAR_NUM) as physical
> addresses.

Oh, right, you have them stored in each bridge, right?  I should do the same 
thing for sn2...

Thanks,
Jesse
