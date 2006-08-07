Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWHGP43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWHGP43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWHGP42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:56:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12188 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932152AbWHGP42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:56:28 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<200608071733.13562.ak@suse.de>
Date: Mon, 07 Aug 2006 09:55:09 -0600
In-Reply-To: <200608071733.13562.ak@suse.de> (Andi Kleen's message of "Mon, 7
	Aug 2006 17:33:13 +0200")
Message-ID: <m11wrsfsma.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Monday 07 August 2006 17:26, Eric W. Biederman wrote:
>> 
>> Currrently on a SMP system we can theoretically support
>> NR_CPUS*224 irqs.  Unfortunately our data structures
>> don't cope will with that many irqs, nor does hardware
>> typically provide that many irq sources.
>> 
>> With the number of cores starting to follow Moores
>> law, and the apicid limits being raised beyond an 8bit
>> number trying to track our current maximum with our
>> current data structures would be fatal and wasteful.
>> 
>> So this patch decouples the number of irqs we support
>> from the number of cpus.  We can revisit this decision
>> once someone reworks the current data structures.
>
> Ok. I was about to apply it, but it seems to require
> mm patches right now, so i didn't

Right.  This is post 2.6.18 material, that is getting
the final bug fixes now.  So it will be ready when 2.6.19 opens
up.  Andi I just wanted to make certain you saw it. :)

Eric
