Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269412AbUIIK2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269412AbUIIK2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269411AbUIIK2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:28:22 -0400
Received: from ozlabs.org ([203.10.76.45]:3000 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269412AbUIIK1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:27:40 -0400
Subject: Re: [PATCH 2/3] cpu: add a CPU_DOWN_PREPARE notifier
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nathan Lynch <nathanl@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <413F0070.2020104@yahoo.com.au>
References: <413EFFFB.5050902@yahoo.com.au>  <413F0070.2020104@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1094725418.25641.21.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 20:23:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 22:52, Nick Piggin wrote:
> 2/3
> 
> Rusty, can I do this?
> 
> ______________________________________________________________________
> Add a CPU_DOWN_PREPARE hotplug CPU notifier. This is needed so we can
> dettach all sched-domains before a CPU goes down, thus we can build
> domains from online cpumasks, and not have to check for the possibility
> of a CPU coming up or going down.

And if taking the CPU down fails?  If you need this, you need the
CPU_DOWN_FAILED as well, unfortunately.  Hence I prefer the "do the
domain thing while machine is frozen" and sidestep it entirely.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

