Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVCHJMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVCHJMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVCHJMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:12:24 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:30392 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261918AbVCHJML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:12:11 -0500
Date: Tue, 8 Mar 2005 12:37:14 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz, David Miller <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel
 2.6
Message-ID: <20050308123714.07d68b90@zanzibar.2ka.mipt.ru>
In-Reply-To: <1FA9E37C-8F90-11D9-A2CF-000393ACC76E@mac.com>
References: <11102278521318@2ka.mipt.ru>
	<1FA9E37C-8F90-11D9-A2CF-000393ACC76E@mac.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 08 Mar 2005 12:11:13 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 00:08:35 -0500
Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On Mar 07, 2005, at 15:37, Evgeniy Polyakov wrote:
> > I'm pleased to announce asynchronous crypto layer for Linux kernel 2.6.
> > It supports following features:
> > - multiple asynchronous crypto device queues
> > - crypto session routing
> > - crypto session binding
> > - modular load balancing
> > - crypto session batching genetically implemented by design
> > - crypto session priority
> > - different kinds of crypto operation(RNG, asymmetrical crypto, HMAC 
> > and
> > any other)
> 
> Did you include support for the new key/keyring infrastructure 
> introduced
> a couple versions ago by David Howells?  It allows userspace to create 
> and
> manage various sorts of "keys" in kernelspace.  If you create and 
> register
> a few keytypes for various symmetric and asymmetric ciphers, you could 
> then
> take advantage of its support for securely passing keys around in and 
> out
> of userspace.

As far as I know, it has different destination - 
for example asynchronous block device, which uses acrypto in one of it's 
filters, may use it.
 
> Cheers,
> Kyle Moffett
> 
> -----BEGIN GEEK CODE BLOCK-----
> Version: 3.12
> GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
> L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
> PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
> !y?(-)
> ------END GEEK CODE BLOCK------
> 


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
