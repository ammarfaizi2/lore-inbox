Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281968AbRKUXHy>; Wed, 21 Nov 2001 18:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281990AbRKUXHk>; Wed, 21 Nov 2001 18:07:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44817 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281968AbRKUXHa>; Wed, 21 Nov 2001 18:07:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Again Multiboot-Standard for Linux ?
Date: 21 Nov 2001 15:07:16 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9thc34$8lb$1@cesium.transmeta.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D772@orsmsx111.jf.intel.com> <166g3I-0ksq00C@fwd06.sul.t-online.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <166g3I-0ksq00C@fwd06.sul.t-online.com>
By author:    "ChristianK."@t-online.de (Christian Koenig)
In newsgroup: linux.dev.kernel
> 
> Beside that, this it is a very nice feature for making an Installation Disk / 
> Distributions.
> AFAIK the newest RedHat distribution use grub as standard Linux Loader,
> if the Linux Kernel is able to load modules before mounting root, you can 
> make a Kernel without any block/bus driver compiled in.
> 

That's already what initrd does.  What would make this interesting --
and why, at least in my opinion, Multiboot is the wrong solution -- is
to make the bootloader smarter about what it loads.  If the boot
loader can *probe* for the device- and filesystem drivers it needs and
thus dynamically compose the kernel in a dynamic manner, then it is
suddenly a win; not sooner.  Multiboot doesn't do that, although it
might be possible to build on top of it to get there.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
