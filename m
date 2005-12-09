Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVLIHPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVLIHPp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 02:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVLIHPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 02:15:45 -0500
Received: from gate.perex.cz ([85.132.177.35]:29329 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932397AbVLIHPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 02:15:44 -0500
Date: Fri, 9 Dec 2005 08:15:42 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Adrian Bunk <bunk@stusta.de>
Cc: Badari Pulavarty <pbadari@gmail.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Re: 2.6.15-rc5-mm1
In-Reply-To: <20051208230203.GA23349@stusta.de>
Message-ID: <Pine.LNX.4.61.0512090814400.9355@tm8103.perex-int.cz>
References: <20051204232153.258cd554.akpm@osdl.org>
 <1134068983.21841.71.camel@localhost.localdomain> <20051208230203.GA23349@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Adrian Bunk wrote:

> On Thu, Dec 08, 2005 at 11:09:43AM -0800, Badari Pulavarty wrote:
> > On Sun, 2005-12-04 at 23:21 -0800, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
> > 
> > In file included from sound/pci/ens1371.c:2:
> > sound/pci/ens1370.c: In function `snd_audiopci_probe':
> > sound/pci/ens1370.c:2462: error: `spdif' undeclared (first use in this
> > function)sound/pci/ens1370.c:2462: error: (Each undeclared identifier is
> > reported only once
> > sound/pci/ens1370.c:2462: error: for each function it appears in.)
> > sound/pci/ens1370.c:2462: error: `lineio' undeclared (first use in this
> > function)
> > make[2]: *** [sound/pci/ens1371.o] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> 
> Jaroslav, this seems to come from your
> 
>   [ALSA] ens1371: added spdif and lineio module option
> 
> patch in the ALSA git tree if SUPPORT_JOYSTICK=n.

It's already fixed in ALSA git tree:

    [ALSA] ens1371: fix compilation without SUPPORT_JOYSTICK

    Modules: ENS1370/1+ driver

    Move the spdif and lineio parameters around so that they are compiled
    even when SUPPORT_JOYSTICK isn't set.

    Signed-off-by: Clemens Ladisch <clemens@ladisch.de>


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
