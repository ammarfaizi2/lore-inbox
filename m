Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVC2Hht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVC2Hht (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVC2H2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:28:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31680 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262535AbVC2HR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:17:57 -0500
Message-ID: <42490104.8040302@pobox.com>
Date: Tue, 29 Mar 2005 02:17:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: folkert@vanheusden.com, Andrew Morton <akpm@osdl.org>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de> <424324F1.8040707@pobox.com> <20050327171934.GB18506@muc.de> <20050327185500.GP943@vanheusden.com> <20050328152043.GA26121@muc.de>
In-Reply-To: <20050328152043.GA26121@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> BTW what do you do when the FIPS test fails? I dont see a good fallback
> path for this case.

If the FIPS test fails, do the obvious:  don't feed that data to the 
kernel (and credit entropy), and possibly stop using the hardware RNG 
under a human has intervened.

This is not rocket science.  The fallback path is "use software", which 
is what most users do right now anyway.

	Jeff

