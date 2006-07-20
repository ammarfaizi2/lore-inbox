Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWGTLwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWGTLwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 07:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWGTLwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 07:52:37 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:4749 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1030240AbWGTLwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 07:52:37 -0400
Message-ID: <44BF6DC5.4030708@s5r6.in-berlin.de>
Date: Thu, 20 Jul 2006 13:49:25 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Martin Waitz <tali@admingilde.org>, Randy Dunlap <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][kernel-doc] Add DocBook documentation for workqueue functions
References: <200607201145.19147.eike-kernel@sf-tec.de>
In-Reply-To: <200607201145.19147.eike-kernel@sf-tec.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
[...]
>  int fastcall schedule_work(struct work_struct *work)
>  {
>  	return queue_work(keventd_wq, work);
>  }
>  EXPORT_SYMBOL(schedule_work);
>  
> +/**
> + * schedule_work - put work task in global workqueue after delay

This should read "schedule_delayed_work".

> + *
> + * @work: job to be done
> + * @delay: number of jiffies to wait
> + *
> + * After waiting for a given time this puts a job in the kernel-global
> + * workqueue.
> + */
>  int fastcall schedule_delayed_work(struct work_struct *work, unsigned long delay)
>  {
>  	return queue_delayed_work(keventd_wq, work, delay);
>  }
>  EXPORT_SYMBOL(schedule_delayed_work);
>  
> +/**
> + * schedule_work - queue work in global workqueue on specific CPU after delay

"schedule_delayed_work_on"

> + *
> + * @cpu: cpu to use
> + * @work: job to be done
> + * @delay: number of jiffies to wait
> + *
> + * After waiting for a given time this puts a job in the kernel-global
> + * workqueue.
> + */
>  int schedule_delayed_work_on(int cpu,
>  			struct work_struct *work, unsigned long delay)
>  {

-- 
Stefan Richter
-=====-=-==- -=== =--==
http://arcgraph.de/sr/
