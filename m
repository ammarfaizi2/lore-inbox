Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130833AbQKPQAX>; Thu, 16 Nov 2000 11:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130900AbQKPQAO>; Thu, 16 Nov 2000 11:00:14 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:64529 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130833AbQKPP76>;
	Thu, 16 Nov 2000 10:59:58 -0500
Message-ID: <3A13FD32.2E0C6721@mandrakesoft.com>
Date: Thu, 16 Nov 2000 10:28:50 -0500
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

Peter Samuelson wrote:
> 
> [Andrzej Krzysztofowicz]
> > Note, that as CONFIG_MCA is defined only for i386 the dependencies on
> > $CONFIG_MCA are no-op for other architectures (in
> > Configure/Menuconfig).  Either CONFIG_MCA should be defined for all
> > architectures or there should be if ... fi around these lines.
> 
> The former, I think.  Less confusing in the long run.
> 
> > BTW, is there any reason for not replacing
> >    bool '  Other ISA cards' CONFIG_NET_ISA
> > by
> >   dep_bool '  Other ISA cards' CONFIG_NET_ISA $CONFIG_ISA
> > to eliminate more drivers from non-ISA arch configs ?
> 
> Looks good to me.  Anything to remove clutter from config menus....

Patch looks ok to me, applied.

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
