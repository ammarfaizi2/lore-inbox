Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVCHMWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVCHMWW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVCHMWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:22:22 -0500
Received: from smtpout.mac.com ([17.250.248.87]:3554 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261456AbVCHMWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:22:18 -0500
In-Reply-To: <20050308123714.07d68b90@zanzibar.2ka.mipt.ru>
References: <11102278521318@2ka.mipt.ru> <1FA9E37C-8F90-11D9-A2CF-000393ACC76E@mac.com> <20050308123714.07d68b90@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ACAE2383-8FCC-11D9-A2CF-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz, David Miller <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Andrew Morton <akpm@osdl.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel 2.6
Date: Tue, 8 Mar 2005 07:22:01 -0500
To: johnpol@2ka.mipt.ru
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 08, 2005, at 04:37, Evgeniy Polyakov wrote:
>>
>> Did you include support for the new key/keyring infrastructure
>> introduced a couple versions ago by David Howells?  It allows
>> user-space to create and manage various sorts of "keys" in
>> kernel-space.  If you create and register a few keytypes for
>> various symmetric and asymmetric ciphers, you could then take
>> advantage of its support for securely passing keys around in
>> and out of userspace.
>
> As far as I know, it has different destination - for example
> asynchronous block device, which uses acrypto in one of it's
> filters, may use it.

I'm not exactly familiar with asynchronous block device, but I'm
guessing that it would need to get its crypto keys from the user
somehow, no?  If so, then the best way of managing them is via
the key/keyring infrastructure.  From the point of view of other
kernel systems, it's basically a set of BLOB<=>task associations
that supports a reasonable inheritance and permissions model.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


