Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVC2DmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVC2DmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 22:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVC2DmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 22:42:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:41685 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262173AbVC2Dlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 22:41:44 -0500
Subject: Re: Mac mini sound woes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1112067369.19014.24.camel@mindpipe>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 13:41:02 +1000
Message-Id: <1112067662.12300.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 22:36 -0500, Lee Revell wrote:
> On Mon, 2005-03-28 at 09:42 +1000, Benjamin Herrenschmidt wrote:
> > It seems that Apple's driver has an in-kernel framework for doing volume
> > control, mixing, and other horrors right in the kernel, in temporary
> > buffers, just before they get DMA'ed (gack !)
> > 
> > I want to avoid something like that. How "friendly" would Alsa be to
> > drivers that don't have any HW volume control capability ? Does typical
> > userland libraries provide software processing volume control ? Do you
> > suggest I just don't do any control ? Or should I implement a double
> > buffer scheme with software gain as well in the kernel driver ?
> 
> alsa-lib handles both mixing (dmix plugin) and volume control (softvol
> plugin) in software for codecs like this that don't do it in hardware.
> Since Windows does mixing and volume control in the kernel (ugh) it's
> increasingly common to find devices that cannot do these.  You don't
> need to handle it in the driver at all.

Yah, OS X does it in the kernel too lately ... at least Apple drivers
are doing it, it's not a "common" lib. They also split treble/bass that
way when you have an iSub plugged on USB and using the machine internal
speakers for treble.

> dmix has been around for a while but softvol plugin is very new, you
> will need ALSA CVS or the upcoming 1.0.9 release.

Ok.

Ben.


