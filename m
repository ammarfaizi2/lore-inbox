Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbVJSEUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbVJSEUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 00:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVJSEUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 00:20:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:15498 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751451AbVJSEUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 00:20:13 -0400
Subject: Re: scsi_eh / 1394 bug - -rt7
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1129693423.8910.54.camel@mindpipe>
References: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com>
	 <1129693423.8910.54.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 00:19:24 -0400
Message-Id: <1129695564.8910.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 23:43 -0400, Lee Revell wrote:
> On Tue, 2005-10-18 at 14:02 -0700, Mark Knecht wrote:
> > Hi,
> >    I'm seeing this each time I plug in a 1394 hard drive:
> > 
> > Attached scsi disk sdc at scsi6, channel 0, id 0, lun 0
> > ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> > ieee1394: Node changed: 0-02:1023 -> 0-01:1023
> > ieee1394: Reconnected to SBP-2 device
> > ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
> > ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00b31ec]
> > prev->state: 2 != TASK_RUNNING??
> > scsi_eh_6/20286[CPU#0]: BUG in __schedule at kernel/sched.c:3328
> 
> I hit this exact same bug while at a client site today, with an external
> USB drive. 

And again on my home machine running -rt1 with my digital camera!

Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
usb 2-1: USB disconnect, address 2
prev->state: 2 != TASK_RUNNING??
scsi_eh_0/12648[CPU#0]: BUG in __schedule at kernel/sched.c:3326
 [<c01048b9>] dump_stack+0x19/0x20 (20)
 [<c011e766>] __WARN_ON+0x46/0x80 (12)
 [<c02c0bf7>] __schedule+0x547/0x790 (84)
 [<c012057a>] do_exit+0x26a/0x430 (28)
 [<c010147b>] kernel_thread_helper+0xb/0x10 (1020129312)

Lee

