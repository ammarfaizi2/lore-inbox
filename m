Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWDRCaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWDRCaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 22:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWDRCaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 22:30:12 -0400
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:27916
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S932150AbWDRCaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 22:30:11 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mvolaski@aecom.yu.edu (Maurice Volaski)
Subject: Re: Bonding driver appears to call a sleeping function from an invalid context in 2.6.17-rc1
Cc: linux-kernel@vger.kernel.org, bonding-devel@lists.sourceforge.net
Organization: Core
In-Reply-To: <a06230907c06487c9cfdf@[129.98.90.227]>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1FVfyg-0008UN-00@gondolin.me.apana.org.au>
Date: Tue, 18 Apr 2006 12:30:06 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maurice Volaski <mvolaski@aecom.yu.edu> wrote:
> At startup, the bonding driver appears to call a sleeping function 
> from an invalid context in 2.6.17-rc1.

Known problem.  Bonding needs to make sure that this stuff gets moved
to a sleepable context since the underlying hardware may require
sleeping to perform the task of setting the MAC address.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
