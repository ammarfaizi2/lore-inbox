Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSGLO55>; Fri, 12 Jul 2002 10:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSGLO54>; Fri, 12 Jul 2002 10:57:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:65030 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316585AbSGLO5z> convert rfc822-to-8bit; Fri, 12 Jul 2002 10:57:55 -0400
Message-ID: <3D2EEF17.8070408@evision-ventures.com>
Date: Fri, 12 Jul 2002 17:00:39 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Thunder from the hill <thunder@ngforever.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: IDE/ATAPI in 2.5
References: <Pine.SOL.4.30.0207121611170.14389-100000@mion.elka.pw.edu.pl> <3D2EE7BA.8080805@evision-ventures.com> <20020712144145.GH22858@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:
> On Fri, Jul 12 2002, Martin Dalecki wrote:
> 
>>Workarounds in ide-cd - none.
> 
> 
> you must be kidding?
> 

OK OK.


	} else  if (ireason == 1) {
		/* Some drives (ASUS) seem to tell us that status
		 * info is available. just get it and ignore.
		 */
		ata_status(drive, 0, 0);
		return 0;
	} else {
		/* Drive wants a command packet, or invalid ireason... */
		printk ("%s: cdrom_read_intr: bad interrupt reason %d\n",
			drive->name, ireason);
	}

Long time not enabled one:

#if !STANDARD_ATAPI
         /* the Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to
            switch CDs instead of supporting the LOAD_UNLOAD opcode   */

         cmd[7] = cdi->sanyo_slot % 3;
#endif

But really nothing scary...

