Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268659AbRGZTjR>; Thu, 26 Jul 2001 15:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268657AbRGZTjI>; Thu, 26 Jul 2001 15:39:08 -0400
Received: from zeus.kernel.org ([209.10.41.242]:34709 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268658AbRGZTi6>;
	Thu, 26 Jul 2001 15:38:58 -0400
Date: Thu, 26 Jul 2001 19:37:41 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfs weirdness
Message-ID: <20010726193741.J19492@grobbebol.xs4all.nl>
In-Reply-To: <20010723154217.F19492@grobbebol.xs4all.nl> <15197.21462.625678.700365@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15197.21462.625678.700365@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Tue, Jul 24, 2001 at 08:54:14PM +1000
X-OS: Linux grobbebol 2.4.6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 08:54:14PM +1000, Neil Brown wrote:
> If you ask to export "/windows" and nothing is mounted on "/windows",
> then you are asking to export part of the root filesystem starting at
> "/windows".  If you subsequently mount something on /windows, then you
> haven't asked for that to be exported so it won't be, and mountd will
> get confused.
> You should always mount filesystems before trying to export them.


well, I tested it for trouble shooting. if I mount the /windows vfat and
export with knfsd it fails. if I do not moiut the vfat, it does. ergo,
the config files are okay, knfsd refuses. 


somebody else pointed out in private mail that knfsd isn't supposed to
be able to export vfat filesystems and unfsd could. if he is correct, I
will have to onstall the other utils again and install unfsd instead.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
