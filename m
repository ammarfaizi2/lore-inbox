Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422719AbWHYPoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWHYPoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWHYPnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:43:50 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:6627 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1422723AbWHYPnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:43:31 -0400
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
From: Daniel Walker <dwalker@mvista.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       akpm@osdl.org, jbarnes@virtuousgeek.org, nickpiggin@yahoo.com.au
In-Reply-To: <1156504939.3032.26.camel@laptopd505.fenrus.org>
References: <1156504939.3032.26.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 08:43:28 -0700
Message-Id: <1156520608.10471.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 13:22 +0200, Arjan van de Ven wrote:

> +void set_acceptable_latency(char *identifier, int usecs);
> +void modify_acceptable_latency(char *identifier, int usecs);
> +void remove_acceptable_latency(char *identifier);
> +void synchronize_acceptable_latency(void);
> +int system_latency_constraint(void);
> +
> +int register_latency_notifier(struct notifier_block * nb);
> +int unregister_latency_notifier(struct notifier_block * nb);


The name space here is bugging me a little. Maybe prefix them with
"pm_latency" so you'd have "pm_latency_set_acceptable()" ,
"pm_latency_modify_acceptable()" , something like that. Likewise with
the file names , "include/linux/pm_latency.h"

Daniel

