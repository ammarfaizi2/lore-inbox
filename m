Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284301AbRLEMXb>; Wed, 5 Dec 2001 07:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284325AbRLEMXW>; Wed, 5 Dec 2001 07:23:22 -0500
Received: from mail.lightning.ch ([193.247.134.3]:20746 "HELO
	mail.lightning.ch") by vger.kernel.org with SMTP id <S284301AbRLEMXH>;
	Wed, 5 Dec 2001 07:23:07 -0500
Message-ID: <3C0E11A8.A3057B7D@lightning.ch>
Date: Wed, 05 Dec 2001 13:23:04 +0100
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
Organization: LIGHTNING Instrumentation SA
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: chose, fr, en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Jeremy Puhlman <jpuhlman@mvista.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endianness-aware mkcramfs
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch> <9uj5fb$1fm$1@cesium.transmeta.com> <20011205013630.C717@nightmaster.csn.tu-chemnitz.de> <3C0D6CB6.7000905@zytor.com> <20011204164941.A29968@one-eyed-alien.net> <20011204170235.M25671@mvista.com> <20011204173819.C29968@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:
> 
> The speed reduction is going to be minimal.  Implement it via macros, like
> it's done everywhere else.  If the endianness is one way, the macros get
> optimized away.  If it's the other way, then they convert into an inlined
> byte swap.
> 
> Yes, there can be a small performance hit, but it's absolutely tiny.
> 

Approved. Byteswapping some metadata fields has a negligible cost.
I did not post this patch in the hope it would be integrated, but
because Jeremy needed it.

If there is consensus about the "always little-endian cramfs" idea,
let's go for it and please ignore this patch.

Have a nice day,


				Daniel Marmier
