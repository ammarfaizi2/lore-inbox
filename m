Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289726AbSAWIHF>; Wed, 23 Jan 2002 03:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289727AbSAWIGp>; Wed, 23 Jan 2002 03:06:45 -0500
Received: from firewall.embl-grenoble.fr ([193.49.43.1]:32422 "HELO
	out.esrf.fr") by vger.kernel.org with SMTP id <S289726AbSAWIGm>;
	Wed, 23 Jan 2002 03:06:42 -0500
Date: Wed, 23 Jan 2002 09:06:14 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: Oliver.Neukum@lrz.uni-muenchen.de
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: umounting
Message-ID: <20020123090614.A18262@pcmaftoul.esrf.fr>
In-Reply-To: <20020122150703.B13509@pcmaftoul.esrf.fr> <m16T2IB-02103HC@ligsg2.epfl.ch> <16T6BH-1ZiPWiC@fwd07.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <16T6BH-1ZiPWiC@fwd07.sul.t-online.com>; from 520047054719-0001@t-online.de on Tue, Jan 22, 2002 at 08:01:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 08:01:44PM +0100, Oliver Neukum wrote:
> 
> > When a second user comes and unmounts a disk, then the data are flushed
> > (the old data) and he gets a fs corruption, because the data were not from
> > his disk.
> 
> No. The sbp2 driver should report a disk change. If such a thing happens,
According to my log, sbp2 has an event, It does see the new disk as I
can mount it ( something bizarre: The first disk I plug, the sbp2 driver
tells me the vendor and model of the disk, but all other disk won't tell
me anything until I realod sbp2 module ( I think reloading is ok but not
tested
> there's a kernel bug. Pulling out a mounted disk may cause a corrupted
> filesystem on that disk but not on others.
That's why I'm writing here: If a user broke his filesystem because he
forget to do umout, that's his fault but when a user do the right thing
but because the previous one haven't It brokes his fs, that's something
not normal and It should be avoided.
        Sam
> 
> 	Regards
> 		Oliver
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
