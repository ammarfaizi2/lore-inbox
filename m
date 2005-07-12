Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVGLIXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVGLIXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVGLIXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:23:25 -0400
Received: from pop.gmx.de ([213.165.64.20]:46491 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261257AbVGLIXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:23:23 -0400
X-Authenticated: #6553809
Message-ID: <42D37DF5.6060902@gmx.net>
Date: Tue, 12 Jul 2005 10:23:17 +0200
From: Thomas Heinz <thomasheinz@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: SCSI DVD-RAM partitions
References: <42CFC3EF.2090804@gmx.net> <20050712023757.GG26128@infradead.org>
In-Reply-To: <20050712023757.GG26128@infradead.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

You wrote:
> While adding support for partitions on sr is trivial it has a huge
> drawback: it's chaning the dev_t space by using up device numbers
> for partitions, so /dev/sr0 ff will have different device numbers
> with that change applied.  I have an old patch that's supposed to
> enable support for partitioned scsi removable devices at
> http://rechner.lst.de/~hch/hacks/sr-parts.diff, I'm not sure it
> actually ever worked (but you should get the basic idea from it)

Ok, thanks for your valuable input. In fact, I thought about making
the device available both as /dev/srX and /dev/sdX at the same time
in order to support partitions. In my case it would even suffice to
make it available as /dev/sdX instead of /dev/srX.

Since I have no expert knowledge about this topic, I would be
interested in the general attitude towards "partitions on SCSI
DVD-RAM media / SCSI removable devices":
- Are partitions intentionally not supported? If so, why?
- Does it usually work but not with my specific DVD-RAM model?
   If so, why?
- Do you think that this should be fixed?


Please note that personally, I can live with the "losetup hack"
since it is easy enough to write a program which encapsulates
partition mounting. However, there might be people which would
prefer plugging in a (possibly pre-)partitioned medium and
having the partitions work out of the box in the expected way.


Regards,

Thomas
