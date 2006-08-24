Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWHXVwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWHXVwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWHXVwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:52:31 -0400
Received: from homer.mvista.com ([63.81.120.158]:24667 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1030483AbWHXVwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:52:30 -0400
Subject: Re: [RFC] maximum latency tracking infrastructure
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
In-Reply-To: <1156441295.3014.75.camel@laptopd505.fenrus.org>
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 14:52:29 -0700
Message-Id: <1156456349.6951.10.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 19:41 +0200, Arjan van de Ven wrote:
> Subject: [RFC] maximum latency tracking infrastructure
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> The patch below adds infrastructure to track "maximum allowable latency" for power
> saving policies.
> 
> The reason for adding this infrastructure is that power management in the
> idle loop needs to make a tradeoff between latency and power savings (deeper
> power save modes have a longer latency to running code again). 
> The code that today makes this tradeoff just does a rather simple algorithm;

I was just thinking that it might be cleaner to register a structure
instead of tracking identifiers to usecs. You might get a speed up on
some of the operations, like unregister.

Another thing I was thinking about is that this seems somewhat contrary
to the idea of using dynamic tick (assuming it was in mainline) to
heuristically pick a power state. Do you have any thoughts on how you
would combine the two?

Daniel

