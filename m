Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTDPWhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbTDPWhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:37:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59876 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261892AbTDPWhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:37:19 -0400
Subject: Re: [PATCH] linux-2.5.67_lost-tick-fix_A2
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       James.Bottomley@SteelEye.com, shemminger@osdl.org, alex@ssi.bg
In-Reply-To: <20030416153259.6f99bb4e.akpm@digeo.com>
References: <1050530545.1077.120.camel@w-jstultz2.beaverton.ibm.com>
	 <20030416153259.6f99bb4e.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050533210.1081.164.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Apr 2003 15:46:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 15:32, Andrew Morton wrote:
> john stultz <johnstul@us.ibm.com> wrote:
> >
> > 	This patch fixes a race in the timer_interrupt code caused by
> > detect_lost_tick().
> 
> Does this also fix the problem which Alex identified?

Nope. It just handles the detect_lost_tick() race and related problems
w/ the PIT causing seq_lock reader starvation. 

I'm still looking over the preempt locking issue he pointed out.

I'll likely send a more cautious version of the patch he already posted
to you. 

thanks
-john


