Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbVLODd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbVLODd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbVLODd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:33:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:46543 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161004AbVLODd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:33:56 -0500
Date: Thu, 15 Dec 2005 04:33:54 +0100
From: Andi Kleen <ak@suse.de>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/6] statistics infrastructure - prerequisite: scatter-gather ringbuffer
Message-ID: <20051215033354.GR23384@wotan.suse.de>
References: <43A044AA.4040103@de.ibm.com> <p73d5jz8r7n.fsf@verdi.suse.de> <43A0D68D.8090405@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A0D68D.8090405@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Relayfs seems to be the right thing to convey streams of incremental 
> pieces of data, like trace records as implemented by 
> arch/s390/kernel/debug.c, for example. Relayfs would work for statistics 
> that involve data growth like a history of a counter, for example, or 
> the raw measurement data reported for statistic updates. I doubt it is 
> the right thing for counters, fill level indicators and histograms; 

For those we traditionally use ASCII files if the data is small.
If it's big relayfs is probably the right answer.

> basically for all types of statistics that do not continuously put their 
> hands on untouched memory to store their results.
> 
> I am currently using debugfs, which works fine for all of these cases. 
> In addition, I need some ringbuffer functionality, though.

IIRC relayfs was changed to be able to handle files in debuggfs by
just plugging in the file operations.

-Andi
