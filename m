Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUBRQmS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUBRQmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:42:18 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:9874 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264446AbUBRQmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:42:15 -0500
Date: Wed, 18 Feb 2004 11:24:14 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Mark Hindley <mark@hindley.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pnp missing proc entries?
Message-ID: <20040218112414.GA10238@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Mark Hindley <mark@hindley.uklinux.net>,
	linux-kernel@vger.kernel.org
References: <20040218074414.GA11598@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218074414.GA11598@titan.home.hindley.uklinux.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 18, 2004 at 07:44:14AM +0000, Mark Hindley wrote:
> Hi,
> 
> I have just switched to 2.6 and am trying to resolve and irq conflict
> between a sound card and internal modem.

Is the pnp layer complaining about this conflict?  Are you using pnpbios 
support?  Are both the sound card and internal modem isapnp devices?

> 
> Looking in Documentation/pnp.txt there should be files in
> proc/bus/isapnp/<node>/{id,resources,options}.
> 
> However all I have is plain node at /proc/bnus/isapnp/<node> that dumps
> some binary data.
> 
> Is the documentation out of date? I can see the calls to make the

Thanks for bringing this to my attention.  I'll update the documentation 
soon.

> missing nodes in pnp_add_device() but can't find it called from
> anywhere. Is this a deliberate omission?
> 
> Thanks
> 
> Mark
> 

You can access this information through sysfs.

try something like this:
mkdir /sys
mount -t sysfs none /sys

Thanks,
Adam

