Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423809AbWJaTR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423809AbWJaTR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423807AbWJaTR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:17:59 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:32387 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423806AbWJaTR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:17:58 -0500
Date: Tue, 31 Oct 2006 21:17:55 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH] 0/3: Fix EH problems in libsas and implement more error handling
Message-ID: <20061031191755.GF4698@rhun.ibm.com>
References: <45468845.20400@us.ibm.com> <20061031105452.GD28239@rhun.haifa.ibm.com> <454791A5.9000202@us.ibm.com> <20061031183239.GE4698@rhun.ibm.com> <4547981F.6040006@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4547981F.6040006@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 10:38:23AM -0800, Darrick J. Wong wrote:
> Muli Ben-Yehuda wrote:
> 
> > Ok, I'll re-run with printk timestamps.
> 
> Thanks!

[    0.000000] Linux version 2.6.19-rc4mx (muli@cluwyn) (gcc version 4.0.3) #58 SMP Tue Oct 31 20:48:13 IST 2006
snip...
[ 1062.470624] aic94xx: escb_tasklet_complete: REQ_TASK_ABORT, reason=0x6
[ 1062.516206] aic94xx: tmf tasklet complete
[ 1062.543056] aic94xx: tmf resp tasklet
[ 1062.573523] aic94xx: tmf came back
[ 1062.603114] aic94xx: task not done, clearing nexus
[ 1062.639986] aic94xx: asd_clear_nexus_tag: PRE
[ 1062.674182] aic94xx: asd_clear_nexus_tag: POST
[ 1062.709161] aic94xx: asd_clear_nexus_tag: clear nexus posted, waiting...
[ 1062.709259] aic94xx: task 0xffff8100b95d1080 done with opcode 0x23 resp 0x0 stat 0x8d but aborted by upper layer!
[ 1062.709266] aic94xx: asd_clear_nexus_tasklet_complete: here
[ 1062.709269] aic94xx: asd_clear_nexus_tasklet_complete: opcode: 0x0
[ 1062.914273] aic94xx: came back from clear nexus
[ 1062.949506] aic94xx: task 0xffff8100b95d1080 aborted, res: 0x0
[ 1062.992706] sas: command 0xffff810193f66800, task 0xffff8100b95d1080, aborted by initiator: EH_NOT_HANDLED
[ 1063.059105] sas: Enter sas_scsi_recover_host
[ 1063.092642] sas: going over list...
[ 1063.121747] sas: trying to find task 0xffff8100b95d1080
[ 1063.161355] sas: sas_scsi_find_task: task 0xffff8100b95d1080 already aborted
[ 1063.211994] sas: sas_scsi_recover_host: task 0xffff8100b95d1080 is aborted
[ 1063.261575] sas: --- Exit sas_scsi_recover_host

> > Pointers to the updated firmware and how to update it?
> 
> http://www-307.ibm.com/pc/support/site.wss/document.do?sitestyle=ibm&lndocid=MIGR-62832
> 
> Download ISO, burn ISO to CD, boot system off CD, run gross-looking DOS
> based EGA gooey (and I mean gooey!) update program, reboot.

Yuck, but thanks :-)

Cheers,
Muli
