Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130604AbQKNFc7>; Tue, 14 Nov 2000 00:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130670AbQKNFcu>; Tue, 14 Nov 2000 00:32:50 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:51215 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130604AbQKNFch>; Tue, 14 Nov 2000 00:32:37 -0500
Date: Mon, 13 Nov 2000 23:02:10 -0600
To: Torsten.Duwe@caldera.de
Cc: Chris Evans <chris@scary.beasts.org>, linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
Message-ID: <20001113230210.F18203@wire.cadcamlab.org>
In-Reply-To: <14864.6812.849398.988598@ns.caldera.de> <Pine.LNX.4.21.0011131655430.22139-100000@ferret.lmh.ox.ac.uk> <14864.12007.216381.254700@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14864.12007.216381.254700@ns.caldera.de>; from duwe@caldera.de on Mon, Nov 13, 2000 at 07:11:51PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Torsten Duwe]
> +	for (p = module_name; *p; p++)
> +	{
> +	  if (isalnum(*p) || *p == '_' || *p == '-')
> +	    continue;
> +
> +	  return -EINVAL;
> +	}

I think you just broke at least some versions of devfs.  I don't
remember if the feature is still around, but I know it *used* to be
possible to request_module("/dev/foobar"), which requires '/' in the
name.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
