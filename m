Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422829AbWJLIbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWJLIbD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWJLIbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:31:03 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:36560 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422829AbWJLIbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:31:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GaE8OwLs8vMJpBeVhz1Z0z7Hg5MnVuS8y15mF2HAqvDRyei5qhLRPsfuoiOQe5eKL3XfxdBI6DsjF5pXNGWjAgK5hRz3RJA6awVoBLmCG6Ld4njjp1bfN0gJOhaC+U3vNVEfci0q4/a4mEo3XhCu8ETaypcaJarSi2qeRUdXAEE=
Message-ID: <9e0cf0bf0610120130y5656e99fgf0bb9305d1467b6e@mail.gmail.com>
Date: Thu, 12 Oct 2006 10:30:59 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Paul Mundt" <lethal@linux-sh.org>
Subject: Re: [PATCH 19/26] Dynamic kernel command-line - sh
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Andi Kleen" <ak@suse.de>,
       "Matt Domsch" <Matt_Domsch@dell.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, trini@kernel.crashing.org, davem@davemloft.net,
       ecd@brainaid.de, wli@holomorphy.com, rc@rc0.org.uk, spyro@f2s.com,
       rth@twiddle.net, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       heiko.carstens@de.ibm.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net
In-Reply-To: <20061012081613.GA8559@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610112111.02040.alon.barlev@gmail.com>
	 <200610112117.10698.alon.barlev@gmail.com>
	 <200610112116.56120.alon.barlev@gmail.com>
	 <20061012081613.GA8559@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, Paul Mundt <lethal@linux-sh.org> wrote:
> The sh bits look fine, though I'm fairly impartial to this change. It
> doesn't seem like this is going to be needed in very many places..

Thank you for your quick response!
But I failed to push i386 command-line size to more than 256 bytes...
You are right, it is required only for memory extreme devices...

Options:
1. Add COMMAND_LINE_SIZE to kernel config - was rejected because
kernel has already too much parameters, this was the initial patch
more than a year ago.
2. Just increase COMMAND_LINE_SIZE of i386, x86_64 - was rejected
because of it affecting low memory devices.
3. Convert the command-line into dynamically allocated buffers - this try.

> In the future, you may also wish to CC linux-arch if you want the
> attention of architecture maintainers.

Thank you, I was not aware of this.
I hope there will be no take 3 :)

Best Regards,
Alon Bar-Lev.
