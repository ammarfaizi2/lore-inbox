Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVHKBoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVHKBoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVHKBoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:44:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55535 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932203AbVHKBoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:44:54 -0400
Subject: Re: [PATCH] latency logger for
	realtime-preempt-2.6.12-final-V0.7.51-30
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Yang Yi <yang.yi@bmrtech.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050804135200.GA14402@elte.hu>
References: <1123042757.2997.5.camel@localhost.localdomain>
	 <20050804135200.GA14402@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 10 Aug 2005 18:44:36 -0700
Message-Id: <1123724676.8187.17.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 15:52 +0200, Ingo Molnar wrote:

> would be nice to clean up the impact of the latency-histogram code some 
> more though: e.g. the #ifdef jungle check_critical_timing() is 
> disgusting. Could be cleaned up by always recording the latency_type 
> being currently traced into a new tr->latency_type field, and then using 
> that in check_critical_timing().

the code appears to be adding ifdefs to make preempt_max_latency work
like preempt_threshold , I think all the nasty ifdefs could go away if
we just made it use preempt_threshold .. Plus it logs latency during
boot up cause preempt_max_latency equals zero .

Daniel

