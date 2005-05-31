Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVEaFRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVEaFRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 01:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVEaFRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 01:17:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:18144 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261736AbVEaFRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 01:17:17 -0400
Date: Tue, 31 May 2005 10:47:30 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: jayush luniya <jayu_11@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: HOTPLUG CPU Support for SMT
Message-ID: <20050531051730.GA5845@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050530152534.21912.qmail@web32806.mail.mud.yahoo.com> <Pine.LNX.4.61.0505301050141.12903@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505301050141.12903@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 04:50:27PM +0000, Zwane Mwaikambo wrote:
> Yes, older 2.6-mm kernel (2.6.10-mm) trees have the "toy" i386 hotplug 
> cpu implementation which does what you want.

AFAIK in the i386 "toy" implementation, when a CPU is offlined, it stops
taking interrupts and stops running tasks, but it _still_ executes a while
loop in the context of its idle task (with IRQs disabled). The loop
is exited when we have to bring online the CPU again. What this means is 
I don't think by offlining the CPU, we are removing any activity associated
with the corresponding h/w thread. 

Maybe the toy implementation could be modified to take care of it? Something
like lowering the priority of the h/w thread so that it consumes minimal 
CPU resources to execute its while loop.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
