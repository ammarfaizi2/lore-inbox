Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310468AbSCPRaN>; Sat, 16 Mar 2002 12:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310470AbSCPR3y>; Sat, 16 Mar 2002 12:29:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:521 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310468AbSCPR3I>; Sat, 16 Mar 2002 12:29:08 -0500
Subject: Re: some ide-scsi commands starve drives on the same cable
To: christian@borntraeger.net (Christian=?iso-8859-1?q?Borntr=E4ger?=)
Date: Sat, 16 Mar 2002 17:45:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
In-Reply-To: <E16mEhy-0004Yj-00@mrvdomng1.kundenserver.de> from "Christian=?iso-8859-1?q?Borntr=E4ger?=" at Mar 16, 2002 02:58:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mIEq-0006nO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> during some activities (e.g. erasing a CDRW or fixating a CDR on my 
> CD-Burner) the hard disc on the same cable cannot be accessed.All data and 
> swap partitions are inaccessable. There is no dmesg output, just entering the
> mount point fails.
> I am not sure if it is a kernel problem or if it is a firmware-bug.

Neither. Its an IDE design limitation. IDE can't handle disconnects like
real scsi does. The fixate command effectively locks the bus until it
completes. 

There has been some movement forward in the standards on this. You might
want to ask our new 2.5 IDE maintainer if/when it will be implemented - I
suspect you have to wait a while though. There is much IDE to clean up first

Alan
