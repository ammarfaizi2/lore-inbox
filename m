Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbRGNSts>; Sat, 14 Jul 2001 14:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264827AbRGNStj>; Sat, 14 Jul 2001 14:49:39 -0400
Received: from t2.redhat.com ([199.183.24.243]:6643 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264797AbRGNSt1>; Sat, 14 Jul 2001 14:49:27 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3B508DB2.86078E16@mandrakesoft.com> 
In-Reply-To: <3B508DB2.86078E16@mandrakesoft.com>  <20010715045842.B6963@weta.f00f.org> <20010715031815.D6722@weta.f00f.org> <200107141414.f6EEEjQ05792@ns.caldera.de> <17573.995129225@redhat.com> <19235.995134153@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Jul 2001 19:49:21 +0100
Message-ID: <20112.995136561@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  malloc.h is extra indirection we don't need.  IMHO
> 	/* malloc.h */
> 	#include <linux/slab.h>
> is a windows interface.  Linux wrappers should be kept to a minimum...

Fine. I can see the logic in that.

mv include/linux/slab.h include/linux/malloc.h
perl -pi -e s/_LINUX_SLAB_H/_LINUX_MALLOC_H/ include/linux/malloc.h
cat > include/linux/slab.h <<EOF
#warning Please include malloc.h not slab.h
#include <linux/malloc.h>
EOF



--
dwmw2


