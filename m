Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRBIVmk>; Fri, 9 Feb 2001 16:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbRBIVmV>; Fri, 9 Feb 2001 16:42:21 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:14869 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129576AbRBIVmQ>; Fri, 9 Feb 2001 16:42:16 -0500
Message-ID: <3A84640B.6F0D31D5@redhat.com>
Date: Fri, 09 Feb 2001 16:41:31 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mario Vanoni <vanonim@dial.eunet.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre9 Kernel panic aic7xxx
In-Reply-To: <3A8450B0.D2B85951@dial.eunet.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Vanoni wrote:
> 
> 1st correction in drivers/scsi/hosts.c (Shane Wegner),
> see lkml, otherwise does not compile.
> 
> Hand written, may not be 100% correct:
> ----------------------------------------------------
> Detected CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
> (scsi1) BRKADRINT error (0x4):
>     Illegal Opcode in sequencer program
> (scsi1) SEQADDR=0x58
> Kernel panic: aic7xxx: unrecoverable BRKADRINT
> 
> In interrupt handler - not syncing
> ----------------------------------------------------
> 
> The machine waits "ad infinitum".
> ----------------------------------------------------

The latest patch I sent Alan had both the hosts.c fix and some other fixes, so
I'm thinking it hasn't made it into his 2.2.19pre9 kernel.  The next one
should work fine as far as aic7xxx is concerned.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
