Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVEDSeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVEDSeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVEDSc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:32:56 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53813
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261377AbVEDScR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:32:17 -0400
Date: Wed, 4 May 2005 20:32:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: avoid infinite loop in x86_64 interrupt return
Message-ID: <20050504183231.GM3899@opteron.random>
References: <20050504050132.GA3899@opteron.random> <200505041100.33099.rjw@sisk.pl> <20050504133129.GD3899@opteron.random> <20050504182142.GE28441@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504182142.GE28441@wotan.suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 08:21:43PM +0200, Andi Kleen wrote:
> To avoid losing schedule events and signals. Between checking for them
> and returning to user space interrupts need to be off. When they are
> reenabled everything needs to be rechecked.

All right good point, the latency issues, they'd wait the timeslice to
expire instead of being processed immediatly. That couldn't be noticed
without some measurement but it's sure worth fixing agreed, thanks!
