Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWIDFFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWIDFFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 01:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWIDFFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 01:05:46 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:22116 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932275AbWIDFFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 01:05:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n/KcPr1/iTTfaHEeY10hchvSD3Ovuqxj+oyFDagVOQAd3j25KQFFoRrP1TmyA8MS8EKRr9Ym+8AHiZctyI0oAsb9RVChWcTCfhARcTumi1WM/44m5Kv3oIuMzbSTpMpj3MHdyjBbFUhuHiKVmLdrmZ3sSF+Uko0mcqHVxI19qOA=
Message-ID: <9e0cf0bf0609032205t2731cedey2eccf7375af0bcd4@mail.gmail.com>
Date: Mon, 4 Sep 2006 08:05:44 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH 00/26] Dynamic kernel command-line
Cc: "Andi Kleen" <ak@suse.de>, "Matt Domsch" <Matt_Domsch@dell.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, matthew@wil.cx, grundler@parisc-linux.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net
In-Reply-To: <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609040050.13410.alon.barlev@gmail.com>
	 <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/06, Paul Mackerras <paulus@samba.org> wrote:
> Alon Bar-Lev writes:
>
> > Current implementation stores a static command-line
> > buffer allocated to COMMAND_LINE_SIZE size. Most
> > architectures stores two copies of this buffer, one
> > for future reference and one for parameter parsing.
>
> Under what circumstances do we actually need a command line of more
> than 256 bytes?

Sure!
With static modules options, splash support, disk encryption, suspend,
local initrd settings we need much more than 256 bytes...

> It seems to me that if 256 bytes isn't enough, we should take a deep
> breath, step back, and think about whether there might be a better way
> to pass whatever information it is that's using up so much of the
> command line.

But the command line is a wonderful tool... It allows you to compile
the same kernel/initramfs and install it on different machines,
modifying only the boot loader configuration file. It also allows
several boot profiles at boot loader level, without the need to
replaces files or have complex initrd...
 So it worth modifying current implementation.

Best Regards,
Alon Bar-Lev.

-- 
VGER BF report: H 0
