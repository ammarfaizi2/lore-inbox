Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVC2Hrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVC2Hrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVC2H1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:27:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49855 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262523AbVC2HQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:16:03 -0500
Message-ID: <424900A2.8010104@pobox.com>
Date: Tue, 29 Mar 2005 02:15:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de> <424324F1.8040707@pobox.com> <20050327171934.GB18506@muc.de>
In-Reply-To: <20050327171934.GB18506@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>We -used- to need data from RNG directly into the kernel randomness 
> 
> 
> Are you sure? I dont think there was ever code to do this in
> mainline. There might have been something in -ac*, but not mainline.

Yes, I am positive.  I wrote the code.  Look at the old Intel RNG driver 
code, before it grew AMD and VIA support, and became hw_random.


>>pool.  The consensus was that the FIPS testing should be moved to userspace.
> 
> 
> Consensus from whom? And who says the FIPS testing is useful anyways?

lkml.  Read the archives.

> I think you just need to trust the random generator, it is like
> you need to trust any other piece of hardware in your machine. Or do you 
> check regularly if you mov instruction still works? @)

Hardware RNGs -have- failed in the past.  And if you are going to credit 
entropy to the data -- a very big deal -- it damn well better be random 
data.  Otherwise failures cascade through the system.


> I think it is a trade off between easy to use and saving of 
> resources and overly paranoia. With an user space solution
> which near nobody uses currently (I am not aware of 
> any distribution that runs that daemon)

Debian does.

It's under-use is mainly because nobody has an RNG.


> it means most people wont have hardware supported randomness
> in their ssh, and I think that is a big drawback.

"big drawback" == 99% of users right now.

	Jeff


