Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTBTQM2>; Thu, 20 Feb 2003 11:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbTBTQM2>; Thu, 20 Feb 2003 11:12:28 -0500
Received: from services.erkkila.org ([24.97.94.217]:32136 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id <S265791AbTBTQM1>;
	Thu, 20 Feb 2003 11:12:27 -0500
Message-ID: <3E5500BF.2000706@erkkila.org>
Date: Thu, 20 Feb 2003 16:22:23 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>,
       linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: vcdxrip , CDROM_SEND_PACKET, and 2.5.42->2.5.43 ide-cd changes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

  I often use vcdxrip to pull mpeg data off of
old vcd's/svcds to archive to tape/dvd. This
worked fine in the 2.5 kernel series up to
2.5.42 where it worked after running the app
more then once ( i assumed it was an initialization
error someplace). After kernel 2.5.43 it no longer
works. I've sent mail to the authors and they
suggested switching it from using ioctl(CDROM_SEND_PACKET)
to ioctl(CDROMREADMODE2) , which does work only
a little slower.

 I've traced it down to cdrom_queue_packet_command() in ide-cd.c
returning a 0 error status from ide_do_drive_cmd(), and
req.data_len is 0, and there doesn't appear to be any sense
available.


I'd appreciate any suggestions for tracking this further
or ideas on possible causes.

-pee


