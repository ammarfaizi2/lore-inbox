Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUDUQWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUDUQWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUDUQWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:22:45 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:2254 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S263389AbUDUQWn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:22:43 -0400
Subject: Re: [PATCH] s390 (7/9): oprofile for s390.
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF4108DD4F.86998596-ONC1256E7D.005641FE-C1256E7D.0059F29D@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 21 Apr 2004 18:22:28 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 21/04/2004 18:22:28
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi Christoph,
nitpicking again?

> Don't you think the name for this file is completly wrong?  And a patch
> name in the comment about this file doesn't exactly help either..

Hmm, traditionally it has been irq.c but you're probably right. profile.c
is a better name for it.

> +#include <linux/smp_lock.h>
> +#include <linux/init.h>
> +#include <asm/system.h>
> +#include <asm/io.h>
> +#include <asm/pgtable.h>
> +#include <asm/delay.h>

These can indeed go.

> > +        if (!((1<<smp_processor_id()) & prof_cpu_mask))
>
> shouldn't this be cpumask_t arithmetic?

Yes, it HAS to be cpumask arithmetic.

> > +//extern int irq_init(struct oprofile_operations** ops);
>
> why this?

Leftovers.

I'll fix these things right away. Thanks for the hints.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


