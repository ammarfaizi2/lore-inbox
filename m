Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbWHQQpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWHQQpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWHQQpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:45:04 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:55348 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S965128AbWHQQpA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:45:00 -0400
In-Reply-To: <Pine.LNX.4.61.0608171541260.24557@yvahk01.tjqt.qr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-scsi-owner@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
       Michael Tokarev <mjt@tls.msk.ru>
MIME-Version: 1.0
Subject: Re: Random scsi disk disappearing
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
From: Andreas Herrmann <AHERRMAN@de.ibm.com>
Message-ID: <OF23DA8DB2.DFFECE8E-ON422571CD.005B6F56-422571CD.005BA03C@de.ibm.com>
Date: Thu, 17 Aug 2006 18:48:50 +0200
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 17/08/2006 18:48:50,
	Serialize complete at 17/08/2006 18:48:50
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.2006 15:41 Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >> It should be the same as
> >>    echo $((7<<6)) > 
/sys/module/scsi_mod/parameters/scsi_logging_level
> >> (which indeed is 448) at runtime, right?  (And yes, 
CONFIG_SCSI_LOGGING
> >> is set to y).
> >
> >> Heh oh those magic numbers!.. ;)
> >

   ...

> Since 7<<6 seems to indicate a flag, it would be best to have some sysfs 

> variable that you can flip using 0 and 1.

It's not a flag. This one sets loglevel 7 for SCSI_LOG_SCAN.
So all SCSI_LOG_SCAN messages might show up.
The loglevel can also be set using sysctl dev.scsi.logging_level.

Anyone interested in a script to conveniently interpret or change the
SCSI logging level? Such a script (scsi_logging_level) exists in the
s390-tools package (version 1.5.3).

If others show interest for this script, maybe a better place can be
found than s390-tools (because it is not really s390-specific).


Regards,

Andreas
