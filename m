Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbUKOUp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUKOUp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbUKOUn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:43:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39625 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261693AbUKOUlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:41:13 -0500
Date: Mon, 15 Nov 2004 21:41:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dean Nelson <dcn@sgi.com>
cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
In-Reply-To: <20041115203343.GA32173@sgi.com>
Message-ID: <Pine.LNX.4.53.0411152139580.19849@yvahk01.tjqt.qr>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com>
 <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> * Dean Nelson (dcn@sgi.com) wrote:
>> > +int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
>>
>> this should be static.
>
>You're right. I made another change in that one now passes the task_struct
>pointer to sched_setscheduler() instead of the pid. This requires that
>the caller of sched_setscheduler() hold the tasklist_lock. The new patch
>for people's feedback follows.

Hi,

can you elaborate a little why passing the task struct/pid is better/worse,
respectively?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
