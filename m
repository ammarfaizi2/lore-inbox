Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSFXSAg>; Mon, 24 Jun 2002 14:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSFXSAf>; Mon, 24 Jun 2002 14:00:35 -0400
Received: from web30.achilles.net ([209.151.1.2]:58282 "EHLO
	web30.achilles.net") by vger.kernel.org with ESMTP
	id <S314553AbSFXSAe> convert rfc822-to-8bit; Mon, 24 Jun 2002 14:00:34 -0400
Message-ID: <3D1271C7.40305@evision-ventures.com>
Date: Fri, 21 Jun 2002 02:22:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Paul Bristow <paul@paulbristow.net>,
       Gadi Oxman <gadio@netvision.net.il>, linux-kernel@vger.kernel.org
Subject: Re: [redone PATCH 2.5.22] simple ide-tape/floppy.c cleanup
References: <Pine.SOL.4.30.0206202302400.14933-200000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Bartlomiej Zolnierkiewicz napisa³:
> redone without controversial bits...
> 
> generic ATAPI hit #1 against 2.5.22:
> 
> 	- move generic ATAPI structs from ide/ide-floppy.c
> 	  and ide/ide-tape.c to include/atapi.h
> 	  (this has a nice side effect of making ide-tape
> 	   a bit more endianness aware)
> 
> 	- remove IDEFLOPPY_MIN/MAX() macros, use generic ones
> 
> 	- add #ifndef __LINUX_ATAPI_H_ blabla to atapi.h
> 	  to prevent including it more than once
> 
> 
> should apply cleanly to 2.5.23


Hi Bartek. Nice to see that you picked up on the idea
of code duplication reduction. I think the solution to
the packet comand declarations problesm will be to
move them over from cdrom.h to linux/scsi.h and just letting
scsi/scsi.h include linux/scsi.h. This should even make
distros still linking to kernle headers from /usr/include
happy and will achieve the goal of unification.

And I agree with Jens that for pragmatic reasons we should
just keep the prefix from cdrom.h - it's there and doesn't hurt
but we need one, so why not stick with it? The plain macros
from scsi.h are too ambigous anyway.




