Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVFYVDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVFYVDe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 17:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVFYVDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 17:03:33 -0400
Received: from dvhart.com ([64.146.134.43]:33202 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261329AbVFYVDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 17:03:24 -0400
Date: Sat, 25 Jun 2005 14:03:22 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <55020000.1119733402@[10.10.2.4]>
In-Reply-To: <1119722905.5762.15.camel@mindpipe>
References: <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]> <20050624170112.GD6393@elte.hu> <320710000.1119632967@flay> <20050624195248.GA9663@elte.hu> <344410000.1119646572@flay> <20050625040052.GB4800@elte.hu> <44570000.1119681732@[10.10.2.4]> <1119722905.5762.15.camel@mindpipe>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Lee Revell <rlrevell@joe-job.com> wrote (on Saturday, June 25, 2005 14:08:25 -0400):

> On Fri, 2005-06-24 at 23:42 -0700, Martin J. Bligh wrote:
>> > (btw., if the TSC is that unreliable on numaq boxes, shouldnt we disable 
>> > it for userspace apps too? Or are those hangs purely kernel bugs? In 
>> > which case it might make sense to debug those a bit more - large-scale 
>> > TSC unsyncedness is something that could slip in on other hardware too.)
>> 
>> Well it reads reliably. it just reliably reads utter random crap (well,
>> across CPUs). Not many things read tsc from userspace, and it won't hang
>> I guess .... depends what their expecations are. I do like gettimeofday
>> not to go backwards though - that tends to bugger things up ;-)
> 
> The userspace apps that read the TSC know what they are doing, and have
> chosen to use the TSC because they need a cheap, fast timer rather than
> a correct one.  Please don't break it.

I have no intent, nor method, of doing so. rdtsc is a direct instruction,
without intervention, as I understand it.

M.

