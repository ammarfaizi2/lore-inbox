Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136122AbRD2Tyk>; Sun, 29 Apr 2001 15:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136156AbRD2Tyb>; Sun, 29 Apr 2001 15:54:31 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:64486 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S136122AbRD2Ty2>; Sun, 29 Apr 2001 15:54:28 -0400
Date: Sun, 29 Apr 2001 13:54:24 -0600
Message-Id: <200104291954.f3TJsO821517@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010429154720.B17155@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>
	<20010428215301.A1052@gruyere.muc.suse.de>
	<200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
	<9cg7t7$gbt$1@cesium.transmeta.com>
	<3AEBF782.1911EDD2@mandrakesoft.com>
	<15083.64180.314190.500961@pizda.ninka.net>
	<20010429153229.L679@nightmaster.csn.tu-chemnitz.de>
	<200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca>
	<20010429145552.A17155@xi.linuxpower.cx>
	<200104291902.f3TJ2Dd21232@vindaloo.ras.ucalgary.ca>
	<20010429154720.B17155@xi.linuxpower.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell writes:
> Would it make sence to have libc use the magic page for all
> syscalls? Then on cpus with a fast syscall instruction, the magic
> page could contain the needed junk in userspace to use it.

That's pretty much what Linus suggested. He proposed having a new
syscall interface which was just calls into the magic page. All
syscalls would thus be available via the magic page. The kernel could
then selectively optimise individual syscalls (like gettimeofday(2))
or optimise the interface into kernel space, without libc ever having
to know about the details.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
