Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbVINLM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbVINLM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 07:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVINLM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 07:12:56 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:29406 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932724AbVINLMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 07:12:55 -0400
Message-ID: <43280793.8070809@stesmi.com>
Date: Wed, 14 Sep 2005 13:20:51 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 2/2] New Omnikey Cardman 4000 driver
References: <20050913155333.GZ29695@sunbeam.de.gnumonks.org> <20050914022314.35eab48d.akpm@osdl.org>
In-Reply-To: <20050914022314.35eab48d.akpm@osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> Harald Welte <laforge@gnumonks.org> wrote:
> 
>>Add new Omnikey Cardman 4000 smartcard reader driver
> 
> 
> - All the open-coded mdelays() are wrong:
> 
>   #define	T_10MSEC	msecs_to_jiffies(10)
>   ...
> 		mdelay(T_10MSEC);
> 
>   mdelay() already takes a jiffies argument.

And isn't that what he's doing?

He wants 10ms. Converts to jiffies (msec_to_jiffies())
and passes it to mdelay().

mdelay(T_10MSEC);
mdelay(msecs_to_jiffies(10));

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFDKAeTBrn2kJu9P78RAh9AAKCuNe3gGCYfi3yEVLglF4Wr1+1CtQCgus3n
ePboO9jbsSSaDkLrG00kvbM=
=k/B4
-----END PGP SIGNATURE-----
