Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292082AbSBTR0o>; Wed, 20 Feb 2002 12:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292063AbSBTR0f>; Wed, 20 Feb 2002 12:26:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13843 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292058AbSBTR03>;
	Wed, 20 Feb 2002 12:26:29 -0500
Message-ID: <3C73DC34.E83CCD35@mandrakesoft.com>
Date: Wed, 20 Feb 2002 12:26:12 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> #ifdef CPU_ARCH_IS_ALPHA
> #warning This looks quite suspect out
>         if ((as->vaddr = (vkaddr_t)(dense_mem((unsigned)as->ioaddr)+(unsigned)as->ioaddr)) == 0) {
> #else
> 
> =====> we are failing at this point
> 
>         if ((as->vaddr = (vkaddr_t)ioremap((unsigned)as->ioaddr, as->msize)) == 0) {
> #endif

ioremap works just fine on alpha.

type abuse aside, and alpha bugs aside, this looks ok... what is the
value of as->msize?

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
