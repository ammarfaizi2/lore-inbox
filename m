Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbQKINwT>; Thu, 9 Nov 2000 08:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129642AbQKINwJ>; Thu, 9 Nov 2000 08:52:09 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60932 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129322AbQKINvv>;
	Thu, 9 Nov 2000 08:51:51 -0500
Message-ID: <3A0AABA0.65CC42FA@mandrakesoft.com>
Date: Thu, 09 Nov 2000 08:50:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrey Panin <pazke@orbita.don.sitek.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media/radio [check_region() removal... ]
In-Reply-To: <E13trtf-0001A3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > 2) i found that some net drivers (3c527.c, sk_mca.c) use io region and
> > don't call request_region() at all. Should they be fixed ?
> 
> Probably.
> 
> MCA bus ensures there can be no collisions of I/O space but it does mean the
> user cannot see what is where as is

Ditto for PCI... it's also a good idea to do it so that another driver
doesn't trample on your I/O space.  I don't think there are any
de4x5/tulip type situations for MCA, but ya never know...

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
