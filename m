Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKOUg7>; Wed, 15 Nov 2000 15:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129671AbQKOUgt>; Wed, 15 Nov 2000 15:36:49 -0500
Received: from host213-120-4-75.host.btclick.com ([213.120.4.75]:22053 "EHLO
	linux.home") by vger.kernel.org with ESMTP id <S129097AbQKOUga>;
	Wed, 15 Nov 2000 15:36:30 -0500
Date: Wed, 15 Nov 2000 20:08:55 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200011152008.UAA20801@linux.home>
To: mike@flyn.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: EJECT ioctl fails on empty SCSI CD-ROM
In-Reply-To: <20001115185958.A5072@dragon.flyn.org>
In-Reply-To: <20001115185958.A5072@dragon.flyn.org>
Reply-To: mistral@stev.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

this is what i get on 2.2.17

open("/dev/scd1", O_RDONLY|O_NONBLOCK)  = 3
ioctl(3, CDROMEJECT, 0xbffffc78)        = 0
close(3)                                = 0



In local.linux-kernel-list, you wrote:
>Apparently using the CDROMEJECT ioctl with kernel 2.4-testX fails on
>a SCSI CD-ROM that does not have a disc in it.  The errno returned
>corresponds to the string ``No such file or directory.''
>
>The Linux CD-ROM Standard states that CDROMEJECT opens the drive tray.
>It does not mention any prerequisite such as media being present.
>
>Is this the expected behavior?  If so, I am curious to hear the rationale
>behind it.


-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  8:00pm  up 32 days,  7:56,  5 users,  load average: 0.17, 0.53, 0.29
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
