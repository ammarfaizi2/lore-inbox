Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271667AbRH0Hjb>; Mon, 27 Aug 2001 03:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271666AbRH0HjW>; Mon, 27 Aug 2001 03:39:22 -0400
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:22952 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S271658AbRH0HjJ>; Mon, 27 Aug 2001 03:39:09 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linuxppc-dev@lists.linuxppc.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac12 ppc ftr_fixup
Date: Mon, 27 Aug 2001 09:39:06 +0200
Message-Id: <20010827073906.21282@smtp.wanadoo.fr>
In-Reply-To: <19943.998872042@kao2.melbourne.sgi.com>
In-Reply-To: <19943.998872042@kao2.melbourne.sgi.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Don't write any code yet, Maciej W. Rozycki has some patches for a
>similar problem in mips and his fix is nicely extensible.  I just need
>confirmation that ftr_fixup needs modutils support.

Right. The feature fixup was originally intended for altivec-specific
cruft in arch/ppc/kernel/*.S, and was only later extended to a few
more things like get_cycles(). It doesn't handle modules, and that
can ideed be an issue. 

I'm looking forward to your modutils. The kernel's do_cpu_ftr_fixups
function has to be modified to take the pointer & size of the fixup
section so that it can be called for modules as well.

Ben.


