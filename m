Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVAZN1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVAZN1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVAZN1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:27:49 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:20099 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262292AbVAZN1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:27:48 -0500
Date: Wed, 26 Jan 2005 14:27:41 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
Message-ID: <20050126132741.GA23182@speedy.student.utwente.nl>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
	fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com> <1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com> <m1sm4phpor.fsf@ebiederm.dsl.xmission.com> <20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net> <m1brbdhl3l.fsf@ebiederm.dsl.xmission.com> <20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net> <m13bwphflw.fsf@ebiederm.dsl.xmission.com> <20050125220229.GB5726@ip68-4-98-123.oc.oc.cox.net> <m1651lupjj.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1651lupjj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:12:00PM -0700, Eric W. Biederman wrote:
> "Barry K. Nathan" <barryn@pobox.com> writes:
> 
> > On Tue, Jan 25, 2005 at 05:12:43AM -0700, Eric W. Biederman wrote:
> > > Could you try this patch on your system with acpi that
> > > is having problems.
> > > 
> > > The patch needs some work before it goes into a mainline kernel
> > > as I have hacked the call to acpi_power_off_prepare into roughly
> > > the proper position in the call chain instead of use a proper
> > > hook.  But I can't quickly find an existing hook in the proper
> > > location.
> > 
> > I had to fix a couple of typos ("apci" and "offf") to get it to compile.
> > Once I did that, the patch made shutdown work again.
> 
> Thanks.  Now I just need to come up with the good version unless one of
> the acpi guys wants to volunteer.

On my box this patch breaks shutdown instead, while it was working without it
on -rc2-mm1.

I have an Asus A7V8X motherboard with a VIA VT8377 (KT400) north bridge and a
VT8235 south bridge (according to lspci). The IO-APIC is used for interrupt
routing.

    Sytse
