Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281659AbRLDSqL>; Tue, 4 Dec 2001 13:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283288AbRLDSo7>; Tue, 4 Dec 2001 13:44:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38674 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282910AbRLDSnX>; Tue, 4 Dec 2001 13:43:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Endianness-aware mkcramfs
Date: 4 Dec 2001 10:42:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9uj5fb$1fm$1@cesium.transmeta.com>
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C0CB59B.EEA251AB@lightning.ch>
By author:    Daniel Marmier <daniel.marmier@lightning.ch>
In newsgroup: linux.dev.kernel
> 
> Here you are, against kernel 2.4.16. The patch is not as clean as one
> would like it to be, but we use it and it works well for us.
> 
> Basically it adds a "-b" (byteorder option) which can take four parameters:
>    -bb	creates a big-endian cramfs,
>    -bl	creates a little-endian cramfs,
>    -bh	creates a cramfs with the same endianness as the host,
>    -br	creates a cramfs with the reverse endianness as the host,
> where "host" refers to the machine running the mkcramfs program.
> 
> As told above, it could be cleaner, but I don't know of a nice method of
> accessing byteorder dependent data through structures.
> 

This isn't the right way to deal with this.  The right way to deal
with this is to get all systems to read cramfs the same way.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
