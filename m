Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280410AbRKXWab>; Sat, 24 Nov 2001 17:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280426AbRKXWaW>; Sat, 24 Nov 2001 17:30:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50697 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280410AbRKXWaP>; Sat, 24 Nov 2001 17:30:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: is 2.4.15 really available at www.kernel.org?
Date: 24 Nov 2001 14:29:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tp711$min$1@cesium.transmeta.com>
In-Reply-To: <2450.1006608941@ocs3.intra.ocs.com.au> <200111241356.fAODuIb30257@ns.caldera.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200111241356.fAODuIb30257@ns.caldera.de>
By author:    Christoph Hellwig <hch@ns.caldera.de>
In newsgroup: linux.dev.kernel
>
> In article <2450.1006608941@ocs3.intra.ocs.com.au> you wrote:
> > kbuild 2.5 has standard support for running user specific install
> > scripts after installing the bootable kernel and modules.  That is, the
> > "update my bootloader" phase can be automated and will propagate from
> > one .config to the next when you make oldconfig.
> 
> Never 2.4 kernels already try to excecute ~/bin/installkernel in the
> 'make install' pass on i386.
> 

Or you can just put in your /sbin/installkernel:

if [ -x $HOME/bin/installkernel ]; then
  exec $HOME/bin/installkernel "$@"
fi

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
