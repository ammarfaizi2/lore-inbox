Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131377AbQKNUxe>; Tue, 14 Nov 2000 15:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131406AbQKNUxW>; Tue, 14 Nov 2000 15:53:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:6410 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S131377AbQKNUxP>;
	Tue, 14 Nov 2000 15:53:15 -0500
Message-ID: <3A119F29.2BD8E7C@mandrakesoft.com>
Date: Tue, 14 Nov 2000 15:23:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries Brouwer <aeb@veritas.com>
CC: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_EISA note in Documentation/Configure.help
In-Reply-To: <00111317072200.00727@localhost.localdomain> <20001114205950.A25349@veritas.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> However, CONFIG_EISA is almost completely superfluous, is not
> required at compile time, can easily be tested at run time,
> in other words adding such an option is a very stupid thing to do.

Each driver's entry in Config.in should be dependent on its
CONFIG_{ISA,EISA,PCI,SBUS,...} defines that indicate what buses are
defined on this particular architecture.  Eventually, DaveM and other
Sparc users will be able to directly source drivers/net/Config.in, and
be presented with the correct list of net drivers given their selected
bus(es).  Ditto for ARM.  Ditto for x86.  Etc.

Disabling code by making global var 'EISA_bus' unconditionally zero was
just an added bonus.  Helps a tiny bit with embedded platforms.


> [Steven, you understand that I would have written under CONFIG_EISA:
> say Y here - there is never any reason to say N, unless there exists
> hardware where the canonical probing hangs the machine.]

Agreed, for the most part.  If you know for sure you don't have an EISA
machine, you can now disable CONFIG_EISA.  IMHO ideally one should be
able to eliminate code that is useless on all but a small subset of
working machines.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
