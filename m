Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289379AbSBNC01>; Wed, 13 Feb 2002 21:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289375AbSBNC0R>; Wed, 13 Feb 2002 21:26:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53764 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289376AbSBNC0F>;
	Wed, 13 Feb 2002 21:26:05 -0500
Message-ID: <3C6B203A.61167C55@mandrakesoft.com>
Date: Wed, 13 Feb 2002 21:26:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Jacobberger <f1j@xmission.com>
CC: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: 2.5.5-pre1 and rd.c
In-Reply-To: <3C6B1883.8080105@xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Jacobberger wrote:
> 
> Trying a make bzImage netted this nice little problem:
> ------------------------------------------------------------------------------------------------------------------------------
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.4/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe
> -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=rd  -c -o
> rd.o rd.c
> rd.c: In function `rd_make_request':
> rd.c:271: too many arguments to function

I would have sworn I merged that with axboe.

Delete the second argument to the function, that should fix it.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
