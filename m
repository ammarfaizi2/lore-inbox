Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285062AbSADWUP>; Fri, 4 Jan 2002 17:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285074AbSADWUF>; Fri, 4 Jan 2002 17:20:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59397 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285062AbSADWTt>; Fri, 4 Jan 2002 17:19:49 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: LSB1.1: /proc/cpuinfo
Date: 4 Jan 2002 14:19:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a159ph$o5n$1@cesium.transmeta.com>
In-Reply-To: <20020104080358.A11215@thyrsus.com> <E16MXjm-0004jo-00@the-village.bc.nu> <20020104234438.G1331@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020104234438.G1331@niksula.cs.hut.fi>
By author:    Ville Herva <vherva@niksula.hut.fi>
In newsgroup: linux.dev.kernel
> > 
> > Nobody I am aware of uses 64bit int default types on a 64bit platform.  Its
> > a waste of memory, bus bandwidth and instruction bandwidth. In almost
> > all cases a 32bit int is quite adequate and since size_t can be 64bit when
> > int is 32bit life works out nicely.
> 
> I *think* long is 32 bit on Windows XP 64bit, though. I imagine they went
> with this hack to ensure backward compability or something. Can't tell for
> sure since the IA64 box lying around hasn't got a bootable Windows on it
> yet, just linux :).
> 
> http://msdn.microsoft.com/library/en-us/win64/64bitwin_4d0z.asp?frame=true
> 

Yes, 'doze uses int == long == 32 bits, long long == void * == 64
bits.  This is because the 'doze API has a bunch of really bogus
assumptions hard-coded in it, back from the days when "portable" in
the M$ world meant "don't use int; use `short' for 16 bits and `long'
for 32 bits."

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
