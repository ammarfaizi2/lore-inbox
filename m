Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbUDRLSI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 07:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUDRLSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 07:18:08 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:16645 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264157AbUDRLSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 07:18:05 -0400
Date: Sun, 18 Apr 2004 12:17:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Rolf Kutz <kutz@netcologne.de>, 244207@bugs.debian.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Bug#244207: kernel-source-2.6.5: mwave gives warning on suspend
Message-ID: <20040418121755.A493@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Rolf Kutz <kutz@netcologne.de>, 244207@bugs.debian.org,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20040417104311.9C13A1D802@jamaika.kutz.dyndns.org> <20040417113918.GA4846@gondor.apana.org.au> <20040417124850.C14786@flint.arm.linux.org.uk> <20040417122322.GA15052@gondor.apana.org.au> <20040417122954.GA7533@gondor.apana.org.au> <20040418103109.GA13756@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040418103109.GA13756@gondor.apana.org.au>; from herbert@gondor.apana.org.au on Sun, Apr 18, 2004 at 08:31:09PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 08:31:09PM +1000, Herbert Xu wrote:
> On Sat, Apr 17, 2004 at 10:29:54PM +1000, herbert wrote:
> > 
> > Please scrap that one, it just makes the module unloadable.
> 
> This patch resolves the problem of the module getting unloaded before
> the device is released by waiting in the module_exit function.

It's still bogus.  The driver gets the sysfs support completely wrong
and the right thing would be to find that change in the BK history and
back it out.

