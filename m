Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313175AbSDDO3N>; Thu, 4 Apr 2002 09:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313176AbSDDO3D>; Thu, 4 Apr 2002 09:29:03 -0500
Received: from ns.suse.de ([213.95.15.193]:27152 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313175AbSDDO2q>;
	Thu, 4 Apr 2002 09:28:46 -0500
Date: Thu, 4 Apr 2002 16:28:44 +0200
From: Dave Jones <davej@suse.de>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pavel@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.5.8-pre1] nbd compile fixes...
Message-ID: <20020404162844.Z20040@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Steve Whitehouse <Steve@ChyGwyn.com>,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	pavel@atrey.karlin.mff.cuni.cz
In-Reply-To: <20020404160206.Y20040@suse.de> <200204041350.OAA17473@gw.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 02:50:25PM +0100, Steven Whitehouse wrote:
 > > 2.4 simply does a s/queue_lock/tx_lock/ on drivers/block/nbd.c
 > > I'll push that to Linus later today
 > Not quite. They cover different things. The queue_lock originally covered the
 > queue and the request sending function. There was an obscure deadlock which
 > could occur in this case hence the split to a spin lock to cover the queue
 > and a semaphore to cover only the request sending function (hence tx_lock
 > rather than queue lock).

*nod* I wussed out and just took the easy bits when I forward ported
those changes from 2.4 
http://www.codemonkey.org.uk/linux-2.5_drivers_block_nbd.c.diff

I dropped the actual fix because it was incompatible with the bio
changes iirc.

 > I've got a 2.5 version of that patch on my patches page at the moment, but
 > due to the block layer changes (if I've understood them correctly) the
 > fix should be done in a slightly different way. The reason that I've not 
 > submitted the patch for 2.5 is that it doesn't yet work and I've not had
 > a chance to investigate properly yet (it hangs on writes sometimes). I'm
 > sure its probably something silly that I've done but I just don't see it
 > at the moment. Any hints or clues are welcome :-)

URL ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
