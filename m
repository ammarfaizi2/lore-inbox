Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287042AbSAEBll>; Fri, 4 Jan 2002 20:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbSAEBld>; Fri, 4 Jan 2002 20:41:33 -0500
Received: from gear.torque.net ([204.138.244.1]:17929 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S286262AbSAEBlU>;
	Fri, 4 Jan 2002 20:41:20 -0500
Message-ID: <3C365A5F.46938829@torque.net>
Date: Fri, 04 Jan 2002 20:43:59 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: deshwar@ctd.hcltech.com
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Reg: SCSI
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eshwar D - CTD, Chennai wrote:

> In my project while reading/writing the data in 
> to scsi disk, I need to block the device using 
> RESERVE UNIT and RELEASE UNIT. Can any one help me
> how to send SCSI command to SCSI device. I know that 
> this can be done under user level using SCSI generic 
> interface. I  required function in kernel version 
> 2.4.2. level.

See:
http://www.linuxdoc.org/HOWTO/SCSI-Generic-HOWTO/

To break reservations from a crippled SCSI initiator, the
other initiator needs access to a SCSI bus reset. Even
though the sg driver supports this, the SCSI mid-level
support is missing in the standard lk 2.4 series. Many
distributions have the required patch (from James
Bottomley) that makes SCSI bus reset functional.

That SCSI bus reset mid-level patch for the lk 2.5 series
will be heading in Jens's direction shortly.

Doug Gilbert
