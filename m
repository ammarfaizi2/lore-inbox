Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbTIKPde (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbTIKPde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:33:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13491 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261377AbTIKPdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:33:22 -0400
Message-ID: <3F6095B5.9010100@pobox.com>
Date: Thu, 11 Sep 2003 11:33:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
CC: linux-kernel@vger.kernel.org, cryptoapi-devel@kerneli.org
Subject: Re: [PATCH] AES i586-asm optimized
References: <20030910153859.GA17919@leto2.endorphin.org> <20030910161738.GA29990@gtf.org> <3F5F5A22.956A72A6@pp.inet.fi>
In-Reply-To: <3F5F5A22.956A72A6@pp.inet.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:
> Jeff Garzik wrote:
> 
>>On Wed, Sep 10, 2003 at 05:38:59PM +0200, Fruhwirth Clemens wrote:
>>
>>>As tested by hvr[2] this implemention is significantly faster than the C
>>>version.
>>
>>Tested on what processors?  With what kernel config?
>>
>>I would be surprised if a 586-optimized asm was useful on P4.
> 
> 
> It uses classic Pentium instruction set. Speed optimized for my 300 MHz
> Pentium-2 test box. Original Gladman version that I started with was pretty
> fast but I was able to improve performance about 7% over original version.
> 
> On my same 300 MHz P2 test box, assembler implementation is about twice as
> fast as the mainline kernel C implementation.


Neat.  Consider me surprised, then  ;-)

Don't take my message as objection to the merge.  I dunno what DaveM or 
JamesM thinks, but I definitely support merging patches like this.  It 
provides a great example, if nothing else.

Eventually I bet there will be issues about automatic algorithm 
selection:  like the RAID5 code, which benchmarks all available 
algorithms, and selects the fastest one.

	Jeff



