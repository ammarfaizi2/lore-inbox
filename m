Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270875AbTHQE2t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 00:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272637AbTHQE2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 00:28:49 -0400
Received: from waste.org ([209.173.204.2]:25053 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270875AbTHQE2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 00:28:48 -0400
Date: Sat, 16 Aug 2003 23:28:47 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, jmorris@inercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030817042847.GL325@waste.org>
References: <200308162040.h7GKeuf07629@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308162040.h7GKeuf07629@adam.yggdrasil.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 01:40:56PM -0700, Adam J. Richter wrote:
> At 2003-08-16 15:51:10, Matt Mackall wrote:
> >The
> >current code uses the stack (though currently rather a lot of it),
> >which lets it be fully re-entrant. Not an option with cryptoapi.
> 
> 	I posted a patch a while ago on one of the linux crypto
> mailing lists that defined these routines to support allocating
> crypto_tfm's on the stack:
> 
> int crypto_tfm_alloc_size(struct crypto_alg *alg, u32 tfm_flags);
> int crypto_tfm_init(struct crypto_tfm *tfm, struct crypto_alg *alg,
>                     u32 tfm_flags);
> 
> 	The patch also created crypto_alg_{get,put} routines so that
> crypto_tfm's could be created quickly without having to look up and
> release references to crypto_alg's.

Indeed. I suggested pretty much the same thing earlier in this thread
and got shot down by davem.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
