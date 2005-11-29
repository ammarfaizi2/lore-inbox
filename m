Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVK2Qrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVK2Qrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVK2Qrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:47:32 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:64730 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932114AbVK2Qrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:47:31 -0500
Date: Tue, 29 Nov 2005 08:52:19 -0800
From: thockin@hockin.org
To: Andi Kleen <ak@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
Message-ID: <20051129165219.GA12687@hockin.org>
References: <1133179554.11491.3.camel@localhost.localdomain> <20051128173040.GA32547@hockin.org> <1133199568.7416.31.camel@mindpipe> <20051128183517.GA4549@hockin.org> <p73r78zh7kv.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r78zh7kv.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 07:06:24AM -0700, Andi Kleen wrote:
> But I'm surprised you're saying 2.6.11 broke. At least 2.6.11 64bit should
> have always used HPET in this case. I only broke it around 2.6.13
> where I added an overeager optimization for single socket DC on my side based
> on a misunderstanding. Earlier and later kernels should have been ok.

we didn't have HPET enabled in BIOS until recently.  Turning that on made
all the TSC gettimeofday() crap disappear.  Now to find and kill any
straggling users of rdtsc
