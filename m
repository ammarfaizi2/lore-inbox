Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312867AbSC0A3W>; Tue, 26 Mar 2002 19:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312871AbSC0A3M>; Tue, 26 Mar 2002 19:29:12 -0500
Received: from ligur.expressz.com ([212.24.178.154]:16575 "EHLO expressz.com")
	by vger.kernel.org with ESMTP id <S312867AbSC0A25>;
	Tue, 26 Mar 2002 19:28:57 -0500
Date: Wed, 27 Mar 2002 01:28:02 +0100 (CET)
From: "BODA Karoly jr." <woockie@expressz.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Malcolm Mallardi <magamo@ranka.2y.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4-ac1 vmware and emu10k1 problems
In-Reply-To: <E16q0ZJ-0004D0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1020327012531.18245B-100000@ligur.expressz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2002, Alan Cox wrote:

> > The vmware modules will not compile properly under 2.4.19-pre4-ac1, or
> > under 2.4.19-pre2-ac2, but compile fine on their mainline kernel
> > counterparts.  Here is the errors that I get from vmware-config.pl:
> Please take vmware problems up with the vmware folks

	I think it would be easy to fix.. He wrote this:

/lib/modules/2.4.19-pre4-ac1/build/include/linux/malloc.h:4: #error
linux/malloc.h is deprecated, use linux/slab.h instead.
make[2]: *** [driver.d] Error 1

	So change in the file where it appeared the 
#include <linux/malloc.h> 
to
#include <linux/slab.h>

-- 
						Woockie
..."what is there in this world that makes living worthwhile?"
Death thought about it. "CATS," he said eventually, "CATS ARE NICE."
			           (Terry Pratchett, Sourcery)

