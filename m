Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVAZOJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVAZOJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVAZOJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:09:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21976 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262305AbVAZOJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:09:08 -0500
To: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com>
	<m1sm4phpor.fsf@ebiederm.dsl.xmission.com>
	<20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net>
	<m1brbdhl3l.fsf@ebiederm.dsl.xmission.com>
	<20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net>
	<m13bwphflw.fsf@ebiederm.dsl.xmission.com>
	<20050125220229.GB5726@ip68-4-98-123.oc.oc.cox.net>
	<m1651lupjj.fsf@ebiederm.dsl.xmission.com>
	<20050126132741.GA23182@speedy.student.utwente.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Jan 2005 07:06:50 -0700
In-Reply-To: <20050126132741.GA23182@speedy.student.utwente.nl>
Message-ID: <m1pszsffnp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sytse Wielinga <s.b.wielinga@student.utwente.nl> writes:

> On my box this patch breaks shutdown instead, while it was working without it
> on -rc2-mm1.
> 
> I have an Asus A7V8X motherboard with a VIA VT8377 (KT400) north bridge and a
> VT8235 south bridge (according to lspci). The IO-APIC is used for interrupt
> routing.

Hmm.  The patch had a couple of hard coded assumptions about the
configuration (using ACPI etc), but I don't think it was significant
enough to break anything.  You have a UP board and a K7 processor
so my removal of set_cpus_allowed that should not affect anything.

But you are using an SMP kernel or at least the apic support.

Are you using ACPI poweroff?

How does the kernel shutdown fail?

Eric
