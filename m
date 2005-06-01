Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVFBABD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVFBABD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVFBAAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:00:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26867 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261518AbVFAX6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:58:49 -0400
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
In-Reply-To: <Pine.OSF.4.05.10506011603560.1707-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506011603560.1707-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 01 Jun 2005 16:58:37 -0700
Message-Id: <1117670317.7646.11.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 16:07 +0200, Esben Nielsen wrote:

> 
> Do you plan to use that callback for priority inheritance?
> If so: It would lead to an recursive algorithm. That is not very nice in
> the kernel with a limited call-stack. It is not so much a problem if the
> mechanism is used in the kernel only, but if it is used for user-space
> locking, which can have unlimited neesting, it is potential problem.

There is an API for for priority inheritance, the call by is strictly
for the PI mechanism to signal when it changes a waiters priority , as
the result of PI.

It's somewhat explained in linux/pi.h . Currently the rt_mutex uses this
callback to move the waiter depending on it's new priority.

I'm not sure I see how this could become recursive, could you explain
more?

Daniel 

