Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135773AbRD2Nc6>; Sun, 29 Apr 2001 09:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135774AbRD2Ncr>; Sun, 29 Apr 2001 09:32:47 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:41682 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135773AbRD2Ncb>; Sun, 29 Apr 2001 09:32:31 -0400
Date: Sun, 29 Apr 2001 15:32:29 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010429153229.L679@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <3AEBF782.1911EDD2@mandrakesoft.com> <15083.64180.314190.500961@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <15083.64180.314190.500961@pizda.ninka.net>; from davem@redhat.com on Sun, Apr 29, 2001 at 04:27:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 04:27:48AM -0700, David S. Miller wrote:
> The idea is that the one thing one tends to optimize for new cpus
> is the memcpy/memset implementation.  What better way to shield
> libc from having to be updated for new cpus but to put it into
> the kernel in this magic page?

Hehe, you have read this MXT patch on linux-mm, too? ;-)

There we have 10x faster memmove/memcpy/bzero for 1K blocks
granularity (== alignment is 1K and size is multiple of 1K), that
is done by the memory controller.

This can only be done in the kernel, because it is critical we
access here.

Good idea.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
