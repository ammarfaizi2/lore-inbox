Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261629AbREOWU2>; Tue, 15 May 2001 18:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbREOWUS>; Tue, 15 May 2001 18:20:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:10253 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261629AbREOWUH>; Tue, 15 May 2001 18:20:07 -0400
Message-ID: <3B01AB60.76CFE75A@transmeta.com>
Date: Tue, 15 May 2001 15:19:12 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Chip Salzenberg <chip@valinux.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zn3V-0003CJ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Wouldn't it be better just to *try* ioctls and see which ones work and
> > which ones don't?
> 
> 1. We have overlaps
> 

1. is of course a problem in itself.  Someone who creates overlapping
ioctls should be spanked, hard.

> 2. I've seen code where people play clever ioctl tricks to deduce a device
> type and it ends up looking like one of those chemistry identification
> charts (hopefully minus do you see smoke ?)
> 
> It should be clean and explicit

Agreed, but "determining type of device" and "determining if interface X
is available on this device" are different operations.  If the latter is
what you want, you want to *explicitly* perform the latter operation.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
