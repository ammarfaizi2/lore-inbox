Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267290AbSKSVUV>; Tue, 19 Nov 2002 16:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbSKSVUV>; Tue, 19 Nov 2002 16:20:21 -0500
Received: from mta03bw.bigpond.com ([139.134.6.86]:36297 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S267290AbSKSVUU>; Tue, 19 Nov 2002 16:20:20 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: Oliver Neukum <oliver@neukum.name>,
       "Folkert van Heusden" <folkert@vanheusden.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: local link configuration daemon?
Date: Wed, 20 Nov 2002 08:15:56 +1100
User-Agent: KMail/1.4.5
References: <003b01c28fed$724a2c80$3640a8c0@boemboem> <200211191827.10622.oliver@neukum.name>
In-Reply-To: <200211191827.10622.oliver@neukum.name>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211200815.56896.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 20 Nov 2002 04:27, Oliver Neukum wrote:
> Am Dienstag, 19. November 2002 18:02 schrieb Folkert van Heusden:
> > Hi,
> >
> > I just read this RFC on 'local link configuration' (mirrored at
> > http://keetweej.vanheusden.com/~folkert/draft-ietf-zeroconf-ipv4-linkloca
> >l. t xt ) and I was wondering: is this planned to be in the kernel? Or
> > should occur this in userspace? (and if so; does it exist?
> > freshmeat/google say it doesn't)
> > Initially I thought I just configure an ip-address in that range on an
> > adapter, but then I read that there is this whole protocol of sending and
> > receiving arp-requests etc.
>
> Brad Hards has done a preliminary implementation that runs in user space.
It was originally done by Sebastian Kuzminsky. It basically uses the kernel's 
packet filter (BPF) and socket code, via Libnet and libpcap. You can get it 
from your friendly kernel.org mirror 
(http://www.XX.kernel.org/pub/software/network/zcip/, where XX is your 
country code).

In the longer term, it might be appropriate to move some of it (the defend 
part of the claim-and-defend sequence) into kernel space. I don't think it 
makes sense to have it all in kernel space.

However since it is still an i-D, and hasn't reached RFC state, I think it is 
better to work up a reference implementation in userspace, and think about 
how much might need to be in the kernel (for performance reasons, whatever) 
when the RFC is released and we have a little deployment experience.

Brad
- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE92qoMW6pHgIdAuOMRAsLhAJ9PBj1DyxSLfPa6JLYUPR81GKhDEwCePEYk
Aznd3lBCdznErhRgtkKNvS4=
=xz4Y
-----END PGP SIGNATURE-----

