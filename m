Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbSLSWJ0>; Thu, 19 Dec 2002 17:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSLSWIO>; Thu, 19 Dec 2002 17:08:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26888 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267452AbSLSWIB>; Thu, 19 Dec 2002 17:08:01 -0500
Message-ID: <3E024522.6000805@transmeta.com>
Date: Thu, 19 Dec 2002 14:16:02 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, terje.eggestad@scali.com, drepper@redhat.com,
       matti.aarnio@zmailer.org, hugh@veritas.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <20021219135517.7E78051FB6@gum12.etpnet.phys.tue.nl> <Pine.LNX.4.44.0212191134180.2731-100000@penguin.transmeta.com> <20021219221043.GA18562@bjl1.asuk.net>
In-Reply-To: <20021219221043.GA18562@bjl1.asuk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Dynamic binaries or libraries can use the indirect call or relocate
> the calls at load time, or if they _really_ want a magic page at a
> position relative to the library, they can just _copy_ the magic page
> from 0xfffe0000.  It is not all that magic.
> 

That would make it impossible for the kernel to have kernel-controlled
data on that page|other page though...

I personally would like to see some better interface than mmap()
/proc/self/mem in order to alias pages, anyway.  We could use a
MAP_ALIAS flag in mmap() for this (where the fd would be ignored, but
the offset would matter.)

	-hpa


