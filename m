Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313816AbSDZKuL>; Fri, 26 Apr 2002 06:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313817AbSDZKuK>; Fri, 26 Apr 2002 06:50:10 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:11785 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S313816AbSDZKuK>; Fri, 26 Apr 2002 06:50:10 -0400
Date: Fri, 26 Apr 2002 14:49:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jurriaan on Alpha <thunder7@xs4all.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: compiling cmipci in 2.5.10 on Alpha doesn't work
Message-ID: <20020426144954.A21937@jurassic.park.msu.ru>
In-Reply-To: <20020426141858.A20449@jurassic.park.msu.ru> <Pine.LNX.4.33.0204261221510.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 12:26:10PM +0200, Jaroslav Kysela wrote:
> <linux/isapnp.h> already includes <linux/pci.h> and there are many files 
> in sound/core, sound/drivers, sound/i2c which really have not anything 
> related to PCI. I think that it's better to include only related header 
> files to optimize compilation (although current CPUs are fast enough).

Ok, this makes sense.

While we are here, there is missing #include <linux/init.h> in
sound/isa/ad1848/ad1848_lib.c, which also breaks compilation on alpha.

Ivan.
