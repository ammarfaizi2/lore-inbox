Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbQKPQBd>; Thu, 16 Nov 2000 11:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130986AbQKPQBX>; Thu, 16 Nov 2000 11:01:23 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:1298 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S130900AbQKPQBN>;
	Thu, 16 Nov 2000 11:01:13 -0500
Message-ID: <3A13FDB1.4B4740E1@mandrakesoft.com>
Date: Thu, 16 Nov 2000 10:30:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PCI configuration changes
In-Reply-To: <200011151005.LAA20027@green.mif.pg.gda.pl> <20001116092539.A2453@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh yeah, another MCA cleanup to consider -- like EISA, there exists a
'MCA_bus' variable which is 0 or 1, depending on the absence or presence
of MCA bus on the current system.

When CONFIG_MCA is enabled, this should be variable like it currently is
[on x86].  When CONFIG_MCA==n, MCA_bus should be unconditionally defined
to zero.

Look at how 'EISA_bus' is handled in test11-pre5...

	Jeff



-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
