Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVDLMtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVDLMtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVDLMtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:49:11 -0400
Received: from kiwi.iasi.rdsnet.ro ([213.157.176.3]:31361 "EHLO
	mail.iasi.rdsnet.ro") by vger.kernel.org with ESMTP id S262329AbVDLMqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:46:14 -0400
Date: Tue, 12 Apr 2005 15:46:11 +0300 (EEST)
From: Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI/HT or Packet Scheduler BUG?
In-Reply-To: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro>
Message-ID: <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Tarhon-Onu Victor wrote:

> 	I am not subscribed to this list so please CC me if you post a reply, 
> if you need additional info or if you suggest a patch (in which I would be 
> very interested).
>
[snip]
> (Intel Xeon or Itanium, AMD Opteron, Dual P3, etc), so I'm not able to tell 
> if it's an ACPI bug, a SMP bug or a Packet Scheduler bug.

 	It seems like this bug is a packed scheduler one and it was 
introduced in 2.6.10-rc2. In the summary of changes from 2.6.10-rc1 to 
2.6.10-rc2 there are a lot of changes announced for the packet 
scheduler.
 	I removed all the changes of the packet scheduler files from the 
incremental patch 2.6.10-rc1 to 2.6.10-rc2, I applied it to 2.6.10-rc1 
and the new 2.6.10-rc2-whithout-sched-changes does not hang.
 	So the problem should be looked in that changes to the pkt sched 
API, the patch containing only those changes is at 
ftp://blackblue.iasi.rdsnet.ro/pub/various/k/patch-2.6.10-sched_changes-from_rc1-to-rc2.gz

-- 
Any views or opinions presented within this e-mail are solely those of
the author and do not necessarily represent those of any company, unless
otherwise expressly stated.
