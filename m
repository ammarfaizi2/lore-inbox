Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267822AbUHERIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267822AbUHERIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUHERIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:08:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38354 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267816AbUHERGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:06:07 -0400
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Jesse Barnes" <jbarnes@engr.sgi.com>, <khalid.aziz@hp.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: [Fastboot] RE: [BROKEN PATCH] kexec for ia64
References: <200407261524.40804.jbarnes@engr.sgi.com>
	<20040730155504.2a51b1fa.rddunlap@osdl.org>
	<m18ycvhx1j.fsf@ebiederm.dsl.xmission.com>
	<B8E391BBE9FE384DAA4C5C003888BE6F01CB2705@scsmsx401.amr.corp.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Aug 2004 11:05:01 -0600
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F01CB2705@scsmsx401.amr.corp.intel.com>
Message-ID: <m1vffxh5xe.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm. Your mailer did not add any references lines.


"Luck, Tony" <tony.luck@intel.com> writes:

> Jesse Barnes wrote:
> >With the addition of some ACPI tables and such.  I don't think 
> >those are freed by the kernel right now though, so it should
> >be pretty easy to point at the originals from the newly kexec'd
> >kernel, or make copies.
> 
> The "trim_bottom" and "trim_top" functions currently modify
> the memory map in place.  But this would only make a difference
> if you tried to kexec a kernel with a smaller granule size than
> the originally running kernel, and even then would only
> result in missing seeing some memory that you might have been
> able to use.

On x86 and x86-64 we can recover the memory map from /proc/iomem.

Does that work on ia64?  Can that be fixed to work on ia64?

All of that information needs to get exported to user space so
/sbin/kexec can pass it to the new kernel.

Eric
