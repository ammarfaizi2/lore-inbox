Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVJRVC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVJRVC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVJRVC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:02:57 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:23305 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932136AbVJRVC5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:02:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iZGbhQD/2H4f/wEouUQwXGXEXR3Y9/7PVH1kwoNDcxFK0cAlcHcrMyou+KYG7wVvwijarlwpyvhPy9kw32IQxF1nExlmzYHNoo2MkYbk9XfwXDWbgin0CM917EdncGkdzqAbANqOL2mtkdv+SQdSXwf82W7X81D/XZfs91+IErM=
Message-ID: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com>
Date: Tue, 18 Oct 2005 14:02:56 -0700
From: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: scsi_eh / 1394 bug - -rt7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I'm seeing this each time I plug in a 1394 hard drive:

Attached scsi disk sdc at scsi6, channel 0, id 0, lun 0
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node changed: 0-02:1023 -> 0-01:1023
ieee1394: Reconnected to SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00b31ec]
prev->state: 2 != TASK_RUNNING??
scsi_eh_6/20286[CPU#0]: BUG in __schedule at kernel/sched.c:3328

Call Trace:<ffffffff801322b1>{__WARN_ON+97} <ffffffff803f8870>{__schedule+608}
       <ffffffff8013434f>{do_exit+1007}
<ffffffff80147300>{keventd_create_kthread+0}
       <ffffffff8010e5ed>{child_rip+15}
<ffffffff80147300>{keventd_create_kthread+0}
       <ffffffff801471f0>{kthread+0} <ffffffff8010e5de>{child_rip+0}

ieee1394: Node resumed: ID:BUS[0-00:1023]  GUID[0050c501e00b31ec]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-02:1023
ieee1394: Reconnected to SBP-2 device
ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
scsi7 : SCSI emulation for IEEE-1394 SBP-2 Devices
lightning linux #

Note: This drive is currently partitioned using the 'Apple Partition
Scheme' and cannot be mounted. (At least by the likes of me!!) Anyway,
more info forthcoming if I can determine what you need.

Thanks,
Mark
