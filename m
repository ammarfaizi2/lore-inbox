Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLKDZq>; Sun, 10 Dec 2000 22:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129640AbQLKDZg>; Sun, 10 Dec 2000 22:25:36 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:52950 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129226AbQLKDZ1>; Sun, 10 Dec 2000 22:25:27 -0500
Message-ID: <3A3441FC.28A2D2CA@haque.net>
Date: Sun, 10 Dec 2000 21:54:52 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Davis <fdavis112@juno.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: INIT_LIST_HEAD marco audit
In-Reply-To: <390158470.976495326591.JavaMail.root@web346-wra.mail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The follwing files probably need to be patched to use the
DECLARE_TASK_QUEUE() macro and new tq_struct, but I don't have time
right now to go through them.

(grep for "static struct tq_struct.*=")

drivers/net/wan/sdlamain.c
drivers/block/paride/pseudo.h
drivers/scsi/atari_NCR5380.c
drivers/scsi/mac_NCR5380.c
drivers/scsi/oktagon_esp.c
drivers/scsi/sun3_NCR5380.c
drivers/isdn/hisax/foreign.c
drivers/isdn/hisax/foreign.c
drivers/isdn/hisax/foreign.c
drivers/acorn/block/mfmhd.c
drivers/pcmcia/i82365.c
drivers/pcmcia/tcic.c
drivers/s390/block/dasd.c

Frank Davis wrote:
> 
> Hello all,
>         It looks like we need to perform an audit of test12-pre8 and find all the changes where INIT_LIST_HEAD should now be used.  Does anyone have a complete list of all the problem drivers, as well as a list of the ones that have already been fixed? If so, please post it to l-k . I don't mind maintaining a list of those patches..Just send them to fdavis112@juno.com .

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
