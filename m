Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161426AbWG2DBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161426AbWG2DBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 23:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161428AbWG2DBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 23:01:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35788 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161426AbWG2DBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 23:01:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Fulghum <paulkf@microgate.com>, ak@muc.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
References: <20060727015639.9c89db57.akpm@osdl.org>
	<1154112276.3530.3.camel@amdx2.microgate.com>
	<20060728144854.44c4f557.akpm@osdl.org>
	<20060728233851.GA35643@muc.de>
	<1154132126.3349.8.camel@localhost.localdomain>
	<1154135792.2557.7.camel@localhost.localdomain>
	<20060728182450.8f5cbf76.akpm@osdl.org>
Date: Fri, 28 Jul 2006 20:58:33 -0600
In-Reply-To: <20060728182450.8f5cbf76.akpm@osdl.org> (Andrew Morton's message
	of "Fri, 28 Jul 2006 18:24:50 -0700")
Message-ID: <m1odv9azhi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Fri, 28 Jul 2006 20:16:32 -0500
> Paul Fulghum <paulkf@microgate.com> wrote:
>
>> On Fri, 2006-07-28 at 19:15 -0500, Paul Fulghum wrote:
>> > I'm doing a build on my home machine now to see if it
>> > happens there also.
>> 
>> Well, the timer int 0 problem does not happen on my home machine.
>> However, it still crashes in early boot for a different reason.
>> 
>> 2.6.18-rc2 works fine with same config.
>> 
>> In this case the error is:
>> 
>> No per-cpu room for modules
>
> yeah, sorry, that's a known problem which nobody appears to be doing
> anything about.  The expansion of NR_IRQS gobbles all the percpu memory in
> the kstat structure.

Sorry I didn't realize it was so easy to trip over.
It's on my todo list for sometime in the next couple of days.

> I assume you have a large NR_CPUS?  Decreasing it should help.

Eric
