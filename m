Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUB1NCM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 08:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUB1NCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 08:02:11 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:2538 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261843AbUB1NCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 08:02:09 -0500
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
In-Reply-To: <20040228003900.GN3883@waste.org>
References: <1077651839.11170.4.camel@leto.cs.pocnet.net>
	 <20040224203825.GV3883@waste.org> <20040225214308.GD3883@waste.org>
	 <1077824146.14794.8.camel@leto.cs.pocnet.net>
	 <20040226200244.GH3883@waste.org>
	 <1077897901.29711.44.camel@leto.cs.pocnet.net>
	 <20040227200214.GK3883@waste.org>
	 <1077912813.2505.8.camel@leto.cs.pocnet.net>
	 <20040227205501.GM3883@waste.org>
	 <1077916595.2773.17.camel@leto.cs.pocnet.net>
	 <20040228003900.GN3883@waste.org>
Content-Type: text/plain
Message-Id: <1077973323.6782.132.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 14:02:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa, den 28.02.2004 schrieb Matt Mackall um 01:39:

> > There's just one small difficulty with having some of the structures in
> > the context: Their size is variable. But known after the init function.
> > So the cra_ctxsize isn't sufficient to describe the length of a tfm
> > strucure. So we need another per-algorithm-category method that returns
> > the additional size required. They might just return iv_size or iv_size
> > + omac_pad_size for ciphers and hmac_pad_size for digests or something
> > like this.
> 
> Hmmm, crypto_alloc_tfm does:
> 
>         tfm = kmalloc(sizeof(*tfm) + alg->cra_ctxsize, GFP_KERNEL);
> 
> So I'm not clear on how the necessary size can be anything else at
> copy time?

Forget it, my mistake. cra_ctxsize is set by the algorithms themselves.


