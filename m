Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287996AbSAHMSM>; Tue, 8 Jan 2002 07:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287997AbSAHMSC>; Tue, 8 Jan 2002 07:18:02 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:60428 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S287996AbSAHMR7>; Tue, 8 Jan 2002 07:17:59 -0500
Message-ID: <3C3AE450.E3255D64@loewe-komp.de>
Date: Tue, 08 Jan 2002 13:21:36 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rene Engelhard <mail@rene-engelhard.de>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Getting ScanLogic USB-ATAPI Adapter to work
In-Reply-To: <20020107211757.A4196@rene-engelhard.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Engelhard schrieb:
> 
> Hi Greg, hi Kernel-Hackers,
> 
> a long time ago I bought the Adapter mentioned above and got it
> working.
> 
> Now, 6 months after that I bought it, my testing is over and I got the
> result: The device is working by changing the usb-storage sources; this
> has not affected any other thing. All my devices (3 of USB) runs perfectly.
> 
> So I send you this patch.
> 
> It's against 2.5.2-pre9 and the patch from Alan with the comment that
> you need SCSI Support is applied in my tree, so this is needed before
> applying this patch (but I saw you did it Greg, you can do this)
> 
> Because of testing this patch 6 months, I do not consider to say that
> this patch is experimental, so I did not write $CONFIG_EXPERIMENTAL at
> the end of the dep_mbool statement.
> 

I sent a patch to unusual_devs.h but didn't get any response yet.
I need to set "CONFIG_SCSI_MULTI_LUN=y" and use the second device for 
CompactFlash.
No other needed change here:


UNUSUAL_DEV(  0x04ce, 0x0002, 0x0074, 0x0074,
                "ScanLogic",
                "SL11R-IDE",
                US_SC_SCSI, US_PR_BULK, NULL,
                US_FL_FIX_INQUIRY),
