Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVC2WGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVC2WGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVC2WGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:06:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:33250 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261527AbVC2WEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:04:40 -0500
Subject: Re: Mac mini sound woes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hu0mugsg2.wl@alsa2.suse.de>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe> <s5h8y46kbx7.wl@alsa2.suse.de>
	 <1112094290.6577.19.camel@gaston> <1112123109.4922.3.camel@mindpipe>
	 <s5hu0mugsg2.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 08:03:40 +1000
Message-Id: <1112133820.5353.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 21:31 +0200, Takashi Iwai wrote:
> At Tue, 29 Mar 2005 14:05:08 -0500,
> Lee Revell wrote:
> > 
> > On Tue, 2005-03-29 at 21:04 +1000, Benjamin Herrenschmidt wrote:
> > > Can the driver advertize in some way what it can do ? depending on the
> > > machine we are running on, it will or will not be able to do HW volume
> > > control... You probably don't want to use softvol in the former case...
> > > 
> > > dmix by default would be nice though :)
> > 
> > No, there's still no way to ask the driver whether hardware mixing is
> > supported yet.  It's come up on alsa-devel before.  Patches are welcome.
> 
> Well I don't remember the discussion thread on alsa-devel about this,
> but it's a good idea that alsa-lib checks the capability of hw-mixing
> and apples dmix only if necessary.  (In the case of softvol, it can
> check the existence of hw control by itself, though.)

Well, for pmac at least, we'll need dmix all the time, but softvol
should be based on what the driver advertises yes.

> Currently, dmix is enabled per driver-type base.  That is, dmix is set
> to default in each driver's configuration which is known to have no hw
> mixing functionality.
> 
> > dmix by default would not be nice as users who have sound cards that can
> > do hardware mixing would be annoyed.  However, in the upcoming 1.0.9
> > release softvol will be used by default for all the mobo chipsets.
> 
> On 1.0.9, dmix will be default, too, for most of mobo drivers.
> 
> 
> Takashi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

