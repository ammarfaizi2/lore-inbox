Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129682AbQKVXEv>; Wed, 22 Nov 2000 18:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129485AbQKVXEb>; Wed, 22 Nov 2000 18:04:31 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46599 "EHLO
        havoc.gtf.org") by vger.kernel.org with ESMTP id <S129385AbQKVXEU>;
        Wed, 22 Nov 2000 18:04:20 -0500
Message-ID: <3A1C49E5.DC34BD54@mandrakesoft.com>
Date: Wed, 22 Nov 2000 17:34:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): pci_device_id tables for linux-2.4.0-test11/drivers/block
In-Reply-To: <200011222201.OAA29131@baldur.yggdrasil.com> <3A1C454E.FC4787CE@mandrakesoft.com> <20001122231854.A29401@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Wed, Nov 22, 2000 at 05:14:38PM -0500, Jeff Garzik wrote:
> > *This* is the over-engineering attitude I was talking about.  The only
> > reason why you are preferring named initializers is because
> > pci_device_id MIGHT be changed.  And if it is changed, it makes the
> > changeover just tad easier.  For that, you ugly up the code and make it
> > more difficult to maintain.
> 
> The other reason is that it makes self documenting code -- no need to look
> up the structure definition to make sense out of the code.

For the general case, that is true.

But note that the general case is usually a -single- structure being
initialized, not an array of structures.  Unless the struct members
being initialized vary wildly from one array element to another, using
named initialized it redundant and -reduces- the ability of the
programmer to look at the pci_tbl[] and evaluate its contents at a
glance.

PCI tables do not use named initalizers on purpose.  It was not an
accident or design mistake.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
