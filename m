Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVDDXWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVDDXWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDDXUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:20:17 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:10757 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261498AbVDDXSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:18:16 -0400
Date: Tue, 5 Apr 2005 09:16:49 +1000
To: "SuD (Alex)" <sud@latinsud.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in i810_audio (reply to herbert)
Message-ID: <20050404231649.GA15649@gondor.apana.org.au>
References: <424F20F6.8010804@latinsud.com> <424FC409.3020808@funkmunch.net> <42507F12.6070009@latinsud.com> <42519E82.50600@latinsud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42519E82.50600@latinsud.com>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 10:07:30PM +0200, SuD (Alex) wrote:
> 
> /* Check for an AC97 1.0 soft modem (ID1) */
> codec->codec_read(codec, AC97_RESET) returned 0xd3a 
> ...
> 
> /* Check for an AC97 2.x soft modem */ ...
> codec->codec_read(codec, AC97_EXTENDED_MODEM_ID) returned 0x1

Interesting.  Can you please try the ALSA drivers and see whether
it works correctly? The modem detection logic lives in
sound/pci/ac97/ac97_codec.c.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
