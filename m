Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262921AbREaAHw>; Wed, 30 May 2001 20:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbREaAHm>; Wed, 30 May 2001 20:07:42 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:5645 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262921AbREaAHb>; Wed, 30 May 2001 20:07:31 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to know HZ from userspace?
Date: 30 May 2001 17:07:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9f41vq$our$1@cesium.transmeta.com>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010530203725.H27719@corellia.laforge.distro.conectiva>
By author:    Harald Welte <laforge@gnumonks.org>
In newsgroup: linux.dev.kernel
> 
> Is there any way to read out the compile-time HZ value of the kernel?
> 
> I had a brief look at /proc/* and didn't find anything.
> 
> The background, why it is needed:
> 
> There are certain settings, for example the icmp rate limiting values,
> which can be set using sysctl. Those setting are basically derived from
> HZ values (1*HZ, for example).
> 
> If you now want to set those values from a userspace program / script in
> a portable manner, you need to be able to find out of HZ of the currently
> running kernel.
> 

Yes, but that's because the interfaces are broken.  The decision has
been that these values should be exported using the default HZ for the
architecture, and that it is the kernel's responsibility to scale them
when HZ != USER_HZ.  I don't know if any work has been done in this
area.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
