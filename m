Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313806AbSDZK1E>; Fri, 26 Apr 2002 06:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313810AbSDZK1D>; Fri, 26 Apr 2002 06:27:03 -0400
Received: from gate.perex.cz ([194.212.165.105]:22793 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S313806AbSDZK1C>;
	Fri, 26 Apr 2002 06:27:02 -0400
Date: Fri, 26 Apr 2002 12:26:10 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Jurriaan on Alpha <thunder7@xs4all.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: compiling cmipci in 2.5.10 on Alpha doesn't work
In-Reply-To: <20020426141858.A20449@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.33.0204261221510.487-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002, Ivan Kokshaysky wrote:

> On Fri, Apr 26, 2002 at 11:17:23AM +0200, Jaroslav Kysela wrote:
> > The real fix is to add '#include <linux/pci.h>' line to all necessary 
> > source files (sound/pci/cmipci.c in this example). Not all source files 
> > need pci.h for compilation.
> 
> Yes, but quite a few of them. Almost all files under sound/pci,
> plus isapnp stuff which needs struct pci_dev and struct pci_bus.
> Including <linux/pci.h> in single place would be much simpler
> and shouldn't break anything, no?

<linux/isapnp.h> already includes <linux/pci.h> and there are many files 
in sound/core, sound/drivers, sound/i2c which really have not anything 
related to PCI. I think that it's better to include only related header 
files to optimize compilation (although current CPUs are fast enough).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

