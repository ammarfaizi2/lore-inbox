Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288556AbSADJIU>; Fri, 4 Jan 2002 04:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSADJIJ>; Fri, 4 Jan 2002 04:08:09 -0500
Received: from mail.s.netic.de ([212.9.160.11]:12819 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S288556AbSADJH5>;
	Fri, 4 Jan 2002 04:07:57 -0500
To: paulus@samba.org
Cc: Richard Henderson <rth@redhat.com>, Tom Rini <trini@kernel.crashing.org>,
        jtv <jtv@xs4all.nl>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102133632.C10362@redhat.com>
	<20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102232320.A19933@xs4all.nl>
	<20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020103004514.B19933@xs4all.nl>
	<20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102160739.A10659@redhat.com>
	<15411.49911.958835.299377@argo.ozlabs.ibm.com>
	<20020103003240.A10838@redhat.com>
	<15412.11822.811712.207946@argo.ozlabs.ibm.com>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 04 Jan 2002 09:48:04 +0100
In-Reply-To: <15412.11822.811712.207946@argo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Thu, 3 Jan 2002 21:10:54 +1100 (EST)")
Message-ID: <87ofka33jv.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Richard Henderson writes:
>
>> On Thu, Jan 03, 2002 at 01:33:27PM +1100, Paul Mackerras wrote:
>> > I look forward to seeing your patch to remove all uses of
>> > virt_to_phys, phys_to_virt, __pa, __va, etc. from arch/alpha... :)
>> 
>> I don't dereference them either, do I?
>
> Does that matter?

No, it doesn't.  C pointers do not behave like machine addresses,
there are additional constraints.

> Also, what does the standard say about casting pointers to integral
> types?  IIRC you aren't entitled to assume that a pointer will fit in
> any integral type, or anything about the bit patterns that you get.

This casting falls into the category "additional language constructs
supported by GCC".  The standard contains wording which encourages
implementors to include a meaningfull conversion from a pointer type
to an integral type, but there is no requirement that this has the
semantics expected by most programmers.
