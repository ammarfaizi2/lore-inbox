Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbVIIUL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbVIIUL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbVIIUL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:11:58 -0400
Received: from magic.adaptec.com ([216.52.22.17]:47310 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030442AbVIIULz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:11:55 -0400
Message-ID: <4321EC85.6080808@adaptec.com>
Date: Fri, 09 Sep 2005 16:11:49 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nish.aravamudan@gmail.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 9/14] sas-class: sas_expander.c Expander discovery
 and configuration
References: <4321E553.6040001@adaptec.com> <29495f1d050909130525f13c7a@mail.gmail.com>
In-Reply-To: <29495f1d050909130525f13c7a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 20:11:54.0587 (UTC) FILETIME=[B91732B0:01C5B57A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/05 16:05, Nish Aravamudan wrote:
> On 9/9/05, Luben Tuikov <luben_tuikov@adaptec.com> wrote:
> 
>>Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>
> 
> 
> <snip>
> 
> 
>>--- linux-2.6.13-orig/drivers/scsi/sas-class/sas_expander.c     1969-12-31 19:00:00.000000000 -0500
>>+++ linux-2.6.13/drivers/scsi/sas-class/sas_expander.c  2005-09-09 11:14:29.000000000 -0400
> 
> 
> <snip>
> 
> +static int sas_ex_general(struct domain_device *dev)
> 
> <snip>
> 
> +                       set_current_state(TASK_INTERRUPTIBLE);
> +                       schedule_timeout(5*HZ);
> 
> Can you use msleep_interruptible() here? I don't see wait-queues in
> the immediate vicinity. If not, and you're going for the normal -mm
> route (and from there to mainline), can you use
> schedule_timeout_interruptible(), please?

Yes, sure.  I don't see why not.

	Luben

