Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWA0M3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWA0M3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWA0M3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:29:04 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:37388 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964987AbWA0M3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:29:01 -0500
Date: Fri, 27 Jan 2006 23:28:56 +1100
To: linux-kernel@vger.kernel.org, dhowells@redhat.com, keyrings@linux-nfs.org
Subject: Re: [PATCH 00/04] Add DSA key type
Message-ID: <20060127122856.GB32128@gondor.apana.org.au>
References: <11380489522362@2gen.com> <E1F2IJr-0007Gu-00@gondolin.me.apana.org.au> <20060127072345.GB4082@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127072345.GB4082@hardeman.nu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 08:23:45AM +0100, David H?rdeman wrote:
> On Fri, Jan 27, 2006 at 12:22:31PM +1100, Herbert Xu wrote:
> >David H?rdeman <david@2gen.com> wrote:
> >>
> >>3) Changes the keyctl syscall to accept six arguments (is it valid to do 
> >>so?)
> >>  and adds encryption as one of the supported ops for in-kernel keys.
> >
> >The asymmetric encryption support should be done inside the crypto/
> >framework rather than as an extension to the key management system.
> 
> It is done inside the crypto/ framework. crypto/dsa.c implements the DSA 
> signing as a hash crypto algorithm (since a DSA signature is two 160-bit 
> integers, the result has a fixed size).

Right.  I mistook the name encrypt to mean generic asymmetric encryption.
Now I see that it is simply an interface to the signature algorithm.
This is fine by me.  However, wouldn't "sign" be a better name for it?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
