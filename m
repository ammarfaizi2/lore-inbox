Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWEHHNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWEHHNQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWEHHNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:13:15 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:18116 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932359AbWEHHNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:13:15 -0400
Date: Mon, 8 May 2006 09:16:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/10] explict migrate tasks for cpu removal
Message-ID: <20060508071633.GA10309@elte.hu>
References: <1147067143.2760.81.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147067143.2760.81.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Shaohua Li <shaohua.li@intel.com> wrote:

> Make cpu_down explictly migrate tasks off dead cpus, this is to fix a 
> dead lock in bulk cpu hotremoval (An example of the deadlock is one 
> dead cpu is notifing udev the cpu is dead and khelper thread is on 
> another dead cpu). Detail info is in the code.

looks good, except some style issues:

> +	/* No need to migrate the tasks: it was best-effort if
> +	 * they didn't do lock_cpu_hotplug().  Just wake up
> +	 * the requestors. */

needs proper comment style.

> +		migration_req_t *req;
> +		req = list_entry(rq->migration_queue.next,
> +				 migration_req_t, list);

missing newline between variables and code.

	Ingo
