Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWHCBBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWHCBBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 21:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWHCBBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 21:01:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52609 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932069AbWHCBBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 21:01:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<20060802183709.GJ3435@redhat.com>
Date: Wed, 02 Aug 2006 19:00:12 -0600
In-Reply-To: <20060802183709.GJ3435@redhat.com> (Don Zickus's message of "Wed,
	2 Aug 2006 14:37:09 -0400")
Message-ID: <m1wt9qr5ur.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

>> 
>> There is one outstanding issue where I am probably requiring too much
> alignment
>> on the arch/i386 kernel.  
>
> There was posts awhile ago about optimizing the kernel performance by
> loading it at a 4MB offset.  
>
> http://www.lkml.org/lkml/2006/2/23/189
>
> Your changes breaks that on i386 (not aligned on a 4MB boundary).  But a
> 5MB offset works.  Is that the correct update or does that break the
> original idea?

That patch should still apply and work as described.

Actually when this stuipd cold I have stops slowing me down,
and I fix the alignment to what it really needs to be ~= 8KB.

Then bootloaders should be able to make the decision.

HPA Does that sound at all interesting?

Eric
