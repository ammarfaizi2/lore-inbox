Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbVIIULb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbVIIULb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVIIULa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:11:30 -0400
Received: from magic.adaptec.com ([216.52.22.17]:15822 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030441AbVIIUL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:11:29 -0400
Message-ID: <4321EC6B.2000205@adaptec.com>
Date: Fri, 09 Sep 2005 16:11:23 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nish.aravamudan@gmail.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <4321E51F.8040906@adaptec.com> <29495f1d05090912591d55be5f@mail.gmail.com>
In-Reply-To: <29495f1d05090912591d55be5f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 20:11:28.0492 (UTC) FILETIME=[A9896AC0:01C5B57A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/05 15:59, Nish Aravamudan wrote:
> On 9/9/05, Luben Tuikov <luben_tuikov@adaptec.com> wrote:
> 
>>Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>
> 
> 
> <snip>
> 
> 
> +static int sas_execute_task(struct sas_task *task, void *buffer, int size,
> +                           int pci_dma_dir)
> 
> <snip>
> 
> +                       set_current_state(TASK_INTERRUPTIBLE);
> +                       schedule_timeout(HZ);
> 
> <snip>
> 
> +                               set_current_state(TASK_INTERRUPTIBLE);
> +                               schedule_timeout(5*HZ);
> 
> Can you use msleep_interruptible() here? I don't see wait-queues in
> the immediate vicinity. If not, and you're going for the normal -mm
> route (and from there to mainline), can you use
> schedule_timeout_interruptible(), please?

Yes, sure.  I don't see why not.

	Luben

