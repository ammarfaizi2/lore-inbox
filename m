Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBWOQa>; Fri, 23 Feb 2001 09:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129065AbRBWOQV>; Fri, 23 Feb 2001 09:16:21 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35345 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129066AbRBWOQH>;
	Fri, 23 Feb 2001 09:16:07 -0500
Message-ID: <3A967081.5CDF5797@mandrakesoft.com>
Date: Fri, 23 Feb 2001 09:15:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: Andrey Panin <pazke@orbita.don.sitek.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/char/serial.c unchecked ioremap() calls
In-Reply-To: <20010223105359.A20170@orbita1.ru> <20010223064543.C12444@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> 
> Em Fri, Feb 23, 2001 at 10:53:59AM +0300, Andrey Panin escreveu:
> >
> > Hi all,
> >
> > 16x50 serial driver doesn't check ioremap() return value.
> > Atached patch should fix this it.
> 
> humm, have not checked, but it seems as if you don't release the previous
> successful mappings on failure. Wipe out this message if I was too quick to
> answer and this is not true. 8)

Also, the proper return from a failed ioremap is -ENOMEM, so I think
Andrey's serial.c patch should modify some functions to return a failure
code...

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
