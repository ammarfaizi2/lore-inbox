Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288112AbSA0Pyq>; Sun, 27 Jan 2002 10:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288102AbSA0Pyg>; Sun, 27 Jan 2002 10:54:36 -0500
Received: from out020pub.verizon.net ([206.46.170.176]:49598 "EHLO
	out020.verizon.net") by vger.kernel.org with ESMTP
	id <S288112AbSA0PyZ>; Sun, 27 Jan 2002 10:54:25 -0500
Date: Sun, 27 Jan 2002 10:51:17 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ide-scsi compile in 2.5
Message-ID: <20020127105117.A571@s>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020127024631.A28936@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020127024631.A28936@wotan.suse.de>; from ak@suse.de on Sun, Jan 27, 2002 at 02:46:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:
> 
> ide-scsi doesn't compile currently in 2.5.x. This patch fixes it in a 
> rather hackish way by adding some kmap_atomic()s.  It would be 
> probably better to kmap earlier in process context in the request 
> function instead, but I leave this to the people who know more 
> about IDE/block layer than me (but apparently not compile ide-scsi..)
> I'm also not totally convinced that it is deadlock free here to use
> KM_BOUNCE_READ here, it may be safer to add a new bounce type. 
> You have been warned. 
> 
> I have only tested it without highmem and it works for me. 
> 
> Hopefully there will be eventually a better fix, but for now it 
> allows to burn (and mount if you use /dev/scd* for ide) CDs under 2.5 again. 

There was a brief period when 2.5 was released and changes went in that
it didn't compile.  Then that was fixed, but it couldn't mount or burn,
but that was also fixed.

I burned a CD a few days ago and it worked fine.  Maybe you have a
partial patch hanging around or something.

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjxUIewACgkQBMKxVH7d2wrDwACgrG0Nidkkl1uw6pSu33+NKxFR
9lwAnREktZYiYo2sKTSL4kpWLSnRK4BY
=43xD
-----END PGP SIGNATURE-----
