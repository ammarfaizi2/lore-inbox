Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUBTTop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUBTTlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:41:24 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:45785 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261391AbUBTTXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:23:43 -0500
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
From: Christophe Saout <christophe@saout.de>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@intercode.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040220190926.GB9980@certainkey.com>
References: <20040219170228.GA10483@leto.cs.pocnet.net>
	 <20040219111835.192d2741.akpm@osdl.org>
	 <20040220171427.GD9266@certainkey.com>
	 <20040220185340.GA14358@leto.cs.pocnet.net>
	 <20040220190926.GB9980@certainkey.com>
Content-Type: text/plain
Message-Id: <1077305023.14976.6.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 20:23:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, den 20.02.2004 schrieb Jean-Luc Cooke um 20:09:

> > The plan was to du <cipher>-<iv mode> where <iv mode> can be
> > ecb (well, no IV at all), plain (unhashed sector number) or a
> > digest (hmac_key sector number). CBC mode is implicit when you
> > have some kind of IV generation. Everything else doesn't make
> > sense and would be redundant. CFB and CTR are not implemented
> > by cryptoloop BTW.
> 
> jlcooke:~/kern/linux-2.6.1/crypto$ grep CTR *.c
> cipher.c:       case CRYPTO_TFM_MODE_CTR:
> grep CFB *.c
> cipher.c:       case CRYPTO_TFM_MODE_CFB:
> 
> It should be I wrote it...the crypto part anyways.

Do you think I should add support for those two (even though they're not
implemented yet)? Does this make sense?

If so, I would do: <cipher>-<cipher mode>[-<iv generator>]

aes-ecb, aes-cbc-sha1, etc...?

This would already break the userspace interface... ;)


