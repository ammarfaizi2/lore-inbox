Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129656AbQKHUuH>; Wed, 8 Nov 2000 15:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbQKHUt5>; Wed, 8 Nov 2000 15:49:57 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:63247 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129656AbQKHUtq>;
	Wed, 8 Nov 2000 15:49:46 -0500
Date: Wed, 8 Nov 2000 21:49:34 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: Jim Bonnet <jimbo@sco.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sb.o support in 2.4-broken?
In-Reply-To: <3A09BD3E.9F2FAF04@sco.com>
Message-ID: <Pine.LNX.4.21.0011082145490.2326-100000@toor.thn.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jim Bonnet wrote:

> I am using the 2.4.0-test10 kernel. I have a sound blaster 16 which
> works fine under 2.2.17.
> 
> I see that a while back someone posted on this problem previously but
> there were no answers I can find..
> 
> Is support for soundblaster16 ISA broken in the 2.4 kernel? Compiled in
> or used as a module I can not get it to work. I have passed sb=220,5,1,5
> during boot when compiled in and also sent those during insmod.
> 
> When I boot to 2.2.17 these are the correct values and sound is happy :)
> 
> I am subbed to this group so you may answer here so this is on record.
> 
> Thanks much...


What does 2.4.* say Jim?
You have the right modutils installed?
Any error msg?

I have an old SB16 ISA and it works without a problem on 2.4.0-test10.
And it hasn't caused me any problems for a very long time :)

I have sound compiled as modules.
My lilo.conf (sound part) looks like this.

path[sound]=/lib/modules/`uname -r`/kernel/drivers/sound
alias sound-service-0-0 opl3
alias sound-slot-0 sb
options sound dmabuf=1
alias midi opl3
options opl3 io=0x388
options sb io=0x220 irq=7 dma=1 dma16=5 mpu_io=0x330

I have no idea if the  sound-service-0-0 and sound-slot-0 part is right
but it works and dosn't give any errors. I haven't had time to check what
service and slot really affects...

Do you get any errors while inserting the modules?



/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6CbxjUSLExYo23RsRAtceAKCfB+8rU1vpBp8GaF2rL7LzUjVB7wCg6yGE
6p0NWko/dIB7/X36nILXGFc=
=gal1
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
