Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135270AbRDLTcd>; Thu, 12 Apr 2001 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135273AbRDLTcU>; Thu, 12 Apr 2001 15:32:20 -0400
Received: from front7.grolier.fr ([194.158.96.57]:53452 "EHLO
	front7.grolier.fr") by vger.kernel.org with ESMTP
	id <S135276AbRDLTaw> convert rfc822-to-8bit; Thu, 12 Apr 2001 15:30:52 -0400
Date: Thu, 12 Apr 2001 18:19:52 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: ernte23@gmx.de
cc: linux-kernel@vger.kernel.org
Subject: Re: scanner problem
In-Reply-To: <3AD5C2BB.A2C82354@gmx.de>
Message-ID: <Pine.LNX.4.10.10104121812410.1240-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001 ernte23@gmx.de wrote:

> hi,
> 
> when trying to scan with xsane and "agfa snapscan 1236s", i get the
> following message:
> 
> Attached scsi generic sg2 at scsi0, channel 0, id 5, lun 0, type 6
> sym53c895-0-<5,*>: target did not report SYNC.

This message is just a warning. If your scanner does not support
synchronous data transfers, then it is ok. You may want to check the doc
of the device on this point.

> sym53c895-0-<5,0>: extraneous data discarded.
> sym53c895-0-<5,0>: COMMAND FAILED (89 0) @cff3d000.

This is the way the driver signals data overrun. Btw, I never used xsane.
If this tool has some trace mode that tells what SCSI commands are sent to
the device, this would help to get such traces.

> what can i do about this?

At least, try to catch the SCSI commands that are sent to the device, and
report them.

  Gérard.

