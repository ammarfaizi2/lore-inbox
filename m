Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWHMVpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWHMVpM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWHMVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:45:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3714 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751594AbWHMVpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:45:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: fastboot@osdl.org, Jan Kratochvil <lace@jankratochvil.net>,
       Horms <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
       dzickus@redhat.com
Subject: Re: [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060807174439.GJ16231@redhat.com>
	<m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
	<20060807235727.GM16231@redhat.com>
	<m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
	<20060809200642.GD7861@redhat.com>
	<m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
	<20060810131323.GB9888@in.ibm.com>
	<m18xlw34j1.fsf@ebiederm.dsl.xmission.com>
	<20060810181825.GD14732@in.ibm.com>
	<m1irl01hex.fsf@ebiederm.dsl.xmission.com>
	<20060811212522.GF18865@redhat.com>
	<m1d5b6zagy.fsf@ebiederm.dsl.xmission.com>
	<p73psf49z9g.fsf@verdi.suse.de>
Date: Sun, 13 Aug 2006 15:44:25 -0600
In-Reply-To: <p73psf49z9g.fsf@verdi.suse.de> (Andi Kleen's message of "13 Aug
	2006 22:06:19 +0200")
Message-ID: <m1r6zkux8m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>> 
>> Do you know what code had problems having _PAGE_NX set.
>> What are we doing with early_ioremap the requires execute
>> permissions.  It doesn't sound right that we would need
>> this.
>
> The early EM64T CPUs didn't support NX and would GPF when
> they hit the bit. That is why you always need to mask 
> with __supported_pte_mask when using _PAGE_NX.

Ok.  Thanks.  That explains that it.

The NX bit itself causes the GPF not someone trying to execute
data on a page.

Eric
