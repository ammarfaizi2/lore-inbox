Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283626AbRLEAkM>; Tue, 4 Dec 2001 19:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283620AbRLEAkC>; Tue, 4 Dec 2001 19:40:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62468 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283621AbRLEAjt>; Tue, 4 Dec 2001 19:39:49 -0500
Message-ID: <3C0D6CB6.7000905@zytor.com>
Date: Tue, 04 Dec 2001 16:39:18 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endianness-aware mkcramfs
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch> <9uj5fb$1fm$1@cesium.transmeta.com> <20011205013630.C717@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:

> 
> Yes, from a CS point of view. 
> 
> But practically cramfs is created once to contain some kind of
> ROM for embedded devices. So if we never modify these data again,
> why not creating it in the required byte order? 
> 
> Why wasting kernel cycles for le<->be conversion? Just because
> it's more general? For writable general purpose file systems it
> makes sense, but to none of romfs, cramfs etc.
> 


Because otherwise you far too easily end up in a situation where every
system suddenly need to be able to support *BOTH* endianisms, at which
point you're really screwed; supporting dual endianism is significantly
more expensive than supporting the "wrong" endianism, and it affects all
systems.

Nip this one in the bud.

	-hpa


